@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Project Bill.Element Entry - B.Plan Link'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZIC_SUPPORT__PBR_BILLPLANLINK
  as select from I_PrjBlgElmEntrBillgPlnLink as PrjBlgElmEntrBillgPlnLnk
 
  association        to parent I_ProjectBillingElementEntry as _ProjectBillingElementEntry   on  $projection.ProjBillgElmntEntrItmUUID = _ProjectBillingElementEntry.ProjBillgElmntEntrItmUUID
  association [1..1] to I_ProjectBillingElement             as _ProjectBillingElement        on  $projection.projectbillingelementuuid = _ProjectBillingElement.ProjectBillingElementUUID

{
  key PrjBlgElmEntrBillgPlnLnk.ProjBillgElmntEntrItmUUID,
      _ProjectBillingElementEntry.ProjectBillingElementUUID,
      PrjBlgElmEntrBillgPlnLnk.BillingPlan,
      PrjBlgElmEntrBillgPlnLnk.BillingPlanItem,
      @Semantics.user.createdBy: true
      PrjBlgElmEntrBillgPlnLnk.CreatedByUser,
      @Semantics.systemDateTime.createdAt: true
      PrjBlgElmEntrBillgPlnLnk.CreationDateTime,
      @Semantics.user.lastChangedBy: true
      PrjBlgElmEntrBillgPlnLnk.LastChangedByUser,
      @Semantics.systemDateTime.lastChangedAt: true
      PrjBlgElmEntrBillgPlnLnk.LastChangeDateTime,
      
      _ProjectBillingElementEntry._ProjectBillingElement._EnterpriseProjectElement.ProcessingStatus,

      //  _SlsDocItemBillingPlanDueDate,
      _ProjectBillingElementEntry,
      _ProjectBillingElement   
}
