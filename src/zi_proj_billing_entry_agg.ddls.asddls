@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Billing Entry aggregation'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_PROJ_BILLING_ENTRY_AGG 

  as select from I_ProjectBillingElement          as BillingElement
  
  left outer join I_ProjectBillingElementEntry     as BillingElementEntry    // [1..*] 
    on  BillingElement.ProjectBillingElementUUID = BillingElementEntry.ProjectBillingElementUUID
    

  left outer join I_ProjectBillingElementEntrFlw   as BillingEntrFlw         // [1..1] 
    on  BillingElementEntry.ProjBillgElmntEntrItmUUID = BillingEntrFlw.ProjBillgElmntEntrItmUUID
            
  left outer join I_PrjBlgElmEntrBillgPlnLink      as BillingPlanLink        // [1..1] 
    on  BillingElementEntry.ProjBillgElmntEntrItmUUID = BillingPlanLink.ProjBillgElmntEntrItmUUID          
            
{
   // --- Key ---
  key BillingElement.ProjectBillingElementUUID,
  
    // --- Expose required field and association for DCL (mandatory as of 2602) ---
   @EndUserText.label:'ProjectElementUUID'
   BillingElement.ProjectElementUUID,
   
   BillingElement._EnterpriseProjectElement,
   
   @EndUserText.label:'Document Currency'
   BillingElementEntry.DocumentCurrency               as DocumentCurrency, 
   
   // --- From I_ProjectBillingElementEntry ---  

   @EndUserText.label:'Planned Revenue'
   @Semantics.amount.currencyCode: 'DocumentCurrency'
   sum( BillingElementEntry.OriginalRevenueAmtInDocCrcy )    as  PlannedRevenue,

   @EndUserText.label:'Unbilled'
   @Semantics.amount.currencyCode: 'DocumentCurrency'     
   sum( BillingElementEntry.OpenRevenueAmtInDocCrcy )    as  Unbilled,
   
   @EndUserText.label:'To Bill Proj'
   @Semantics.amount.currencyCode: 'DocumentCurrency'  
   sum( BillingElementEntry.ToBeBilledAmtInProjCurrency )    as  ToBillProj,
 
   @EndUserText.label:'To Bill Glob'
   @Semantics.amount.currencyCode: 'DocumentCurrency'  
   sum( BillingElementEntry.ToBeBilledAmtInGlobCurrency  )    as  ToBillGlob,
 
   @EndUserText.label:'To Bill Trans'
   @Semantics.amount.currencyCode: 'DocumentCurrency'   
   sum( BillingElementEntry.ToBeBilledAmtInTransCrcy )    as  ToBillTrans, 
     
   @EndUserText.label:'To Bill Total'
   @Semantics.amount.currencyCode: 'DocumentCurrency'  
   sum( BillingElementEntry.ToBeBilledAmtInProjCurrency ) +  sum( BillingElementEntry.ToBeBilledAmtInGlobCurrency  ) +  sum( BillingElementEntry.ToBeBilledAmtInTransCrcy ) as ToBillTotal,

   // --- From I_ProjectBillingElementEntrFlw ---

   @EndUserText.label:'Project Billing Request'
   max( BillingEntrFlw.BillingDocument ) as ProjectBillingRequest,

   @EndUserText.label:'Last Billing Date'
   max( BillingEntrFlw.BillingDate ) as LastBillingDate,

   @EndUserText.label:'Service Organization'
   max( BillingEntrFlw.EnterpriseProjectServiceOrg ) as ServiceOrganization


}

group by BillingElement.ProjectBillingElementUUID,
         BillingElement.ProjectElementUUID,
         BillingElementEntry.DocumentCurrency
