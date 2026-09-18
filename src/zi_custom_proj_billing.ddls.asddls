@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Custom Project Billing Overview'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_CUSTOM_PROJ_BILLING

  as select from    I_ProjectBillingElement     as BillingElement

    left outer join ZI_PROJ_BILLING_ENTRY_AGG   as BillingElementEntryAggregation on BillingElement.ProjectBillingElementUUID = BillingElementEntryAggregation.ProjectBillingElementUUID // [1..1]

  //Add_18.08.26_LGA - Ini
    left outer join ZI_TmpProjectBillingRequest as TmpBillingRequest              on BillingElement.ProjectBillingElementUUID = TmpBillingRequest.ProjectBillingElementUUID // [1..1]
  //Add_18.08.26_LGA - Fin

  //Add_21.08.26_LGA - Ini
    left outer join ZI_ProjectBillingElement    as ProjectBillingElement          on BillingElement.ProjectBillingElementUUID = ProjectBillingElement.ProjectBillingElementUUID // [1..1]
  //Add_21.08.26_LGA - Fin
  //Add_14.09.26_SLC - Ini  
    left outer join ZI_PROJ_BILL_ELMNT_DUE_DATE  as _DueBillingDate               on  BillingElement.ProjectBillingElementUUID = _DueBillingDate.ProjectBillingElementUUID
  //Add_14.09.26_SLC - Fin
  //left outer join P_ProjectBillingElmntDueDate as BillgPlnLink  // No se puede usar esta CDS, ni las superiores I_PrjBlgElmEntrBillgPlnLinkTP, I_ProjectBillingElementTP, P_ProjBillgElmntSalesDets
  //on BillingElement.BillingPlan = BillgPlnLink.BillingPlan
  //
  //BillgPlnLink.DueBillingDate

{
      // Key ***************************************************************************************************
      @EndUserText.label:'Project Billing Element UUID'
  key BillingElement.ProjectBillingElementUUID,

      // Expose required field and association for DCL (mandatory as of 2602)***********************************
      @EndUserText.label:'Project Element UUID'
      BillingElement.ProjectElementUUID,

      BillingElement._EnterpriseProjectElement,

      // From I_ProjectBillingElement **************************************************************************

      @EndUserText.label:'Project Billing Element. WBS Element'
      BillingElement.BillingWBSElementInternalID            as ProjBillElementInternalID, //Del_LGA_21.08.26
      ProjectBillingElement.WBSElementExternalID                      as ProjectBillingElement, //Add_LGA_21.08.26

      @EndUserText.label:'Billing Method. Billing Profile'
      //      BillingElement.ProjBillingProfile                     as BillingMethod,  Del_LGA_21.08.26
      ProjectBillingElement.BillingPlanUsageCategory                  as BillingMethod, //Add_LGA_21.08.26

      @EndUserText.label:'Billed Revenue'
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      BillingElement.BilledRevenueAmtInDocCrcy                        as Billed,

      @EndUserText.label:'Written Off Revenue'
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      BillingElement.WrittenOffRevenueAmtInDocCrcy                    as WrittenOff,

      @EndUserText.label:'Billing Profile Category'
      BillingElement.ProjectBillingCategory                           as ProjectBillingCategory,

      @EndUserText.label:'PBE Created By'
      BillingElement.ProjBillgElmntCreatedByUser                      as ProjBillgElmntCreatedByUser,

      @EndUserText.label:'PBE Created On'
      BillingElement.ProjBillgElmntCreatedAtDteTme                    as ProjBillgElmntCreatedAtDteTme,

      @EndUserText.label:'PBE Changed By'
      BillingElement.ProjBillgElmntLastChgdByUser                     as ProjBillgElmntLastChgdByUser,

      @EndUserText.label:'PBE Changed On'
      BillingElement.ProjBillgElmntLastChgdAtDteTme                   as ProjBillgElmntLastChgdAtDteTme,

      @EndUserText.label:'Bill. Plan No.'
      BillingElement.BillingPlan                                      as BillingPlan,

      @EndUserText.label:'Sales Document'
      BillingElement.SalesDocument                                    as SalesDocument,

      @EndUserText.label:'Sales Document Item'
      BillingElement.SalesDocumentItem                                as SalesDocumentItem,

      @EndUserText.label:'PBE Link UUID'
      BillingElement.PrjBlgElmObjLnkUUID                              as PrjBlgElmObjLnkUUID, //for the delta extraction

      @EndUserText.label:'Document Currency'
      BillingElement.DocumentCurrency                                 as DocumentCurrency,


      //  BillingElement.ProjectElement                    as WorkPackage,
      //  BillingElement.PartnerFunctionName               as Partner,

      // From I_ProjectBillingElementEntry **************************************************************************

      @EndUserText.label:'Planned Revenue'
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      BillingElementEntryAggregation.PlannedRevenue                   as PlannedRevenue,

      @EndUserText.label:'Unbilled'
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      BillingElementEntryAggregation.Unbilled                         as Unbilled,

      @EndUserText.label:'To Bill'
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      BillingElementEntryAggregation.ToBillTotal                      as ToBill,

      //  BillingElementEntry.EstimatedActualsAmtInDocCrcy as EstimatedActuals,
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      ProjectBillingElement.CappedNetAmount                           as Cap, // Add_LGA_21.08.26

      ProjectBillingElement.SalesDocumentItemText                     as WBSElementDescription, // Add_LGA_21.08.26
      //  BillingElementEntry.DownPaymentReceivedAmt       as DownPaymentReceived,


      // From I_ProjectBillingElementEntrFlw  **************************************************************************

      @EndUserText.label:'Project Billing Request'
      TmpBillingRequest.ProjectBillingRequest                         as ProjectBillingRequest, //Add_18.08.26_LGA
      @EndUserText.label:'Project Billing Request UUID'
      TmpBillingRequest.ProjectBillingRequestUUID                     as ProjectBillingRequestUUID, //Add_18.08.26_LGA
      //      BillingElementEntryAggregation.ProjectBillingRequest as ProjectBillingRequest, "Del_18.08.26_LGA

      @EndUserText.label:'Last Billing Date'
      BillingElementEntryAggregation.LastBillingDate                  as LastBillingDate,

      @EndUserText.label:'Service Organization'
      //      BillingElementEntryAggregation.ServiceOrganization    as ServiceOrganization, Del_LGA_21.08.26
      ProjectBillingElement.EngagementProjectServiceOrg               as ServiceOrganization, // Add_LGA_21.08.26

      //  BillingEntrFlw.BillingInProcessAmount            as BillingInProcess,

      // From I_PrjBlgElmEntrBillgPlnLink  **************************************************************************

      _DueBillingDate.DueBillingDate           as BillingDueDate, //Add_SLC_14.09.26
      //  BillingPlanLink.DownPaymentRequestedAmt          as DownPaymentRequested,


      // From I_BuPaIdentification **********************************************************************************

      // From I_EnterpriseProject ***********************************************************************************

      // From I_SalesDocument ***************************************************************************************

      // From I_EnterpriseProjectElement ****************************************************************************

      @EndUserText.label:'Profit Center'
      BillingElement._EnterpriseProjectElement.ProfitCenter           as ProfitCenter,

      // From I_SalesOrder ******************************************************************************************
      @EndUserText.label:'Project'
      //      BillingElement._SalesOrder.EntProjTypeCustomerProject as CustomerProject, Del_LGA_21.08.26
      ProjectBillingElement.Project                                   as CustomerProject, //Add_LGA_21.08.26

      @EndUserText.label:'Customer'
      BillingElement._SalesOrder.SoldToParty                          as Customer,

      //Add_LGA_21.08.26 - Ini
      ProjectBillingElement._SalesOrder.OverallBillingBlockStatus     as OverallBillingBlockStatus,
      ProjectBillingElement._SalesOrder.HeaderBillingBlockReason      as HeaderBillingBlockReason,
      //Add_LGA_21.08.26 - Fin

      // From I_SalesOrderItem **************************************************************************************

      @EndUserText.label:'Bill To Party'
      BillingElement._SalesOrderItem.BillToParty                      as BillToParty,

      @EndUserText.label:'Payer'
      BillingElement._SalesOrderItem.PayerParty                       as Payer,

      @EndUserText.label:'ShipToParty'
      BillingElement._SalesOrderItem.ShipToParty                      as ShipToParty,

      //Add_LGA_21.08.26 - Ini
      ProjectBillingElement._SalesOrderItem.SDDocumentRejectionStatus as SDDocumentRejectionStatus,
      ProjectBillingElement._SalesOrderItem.BillingBlockStatus        as BillingBlockStatus,
      ProjectBillingElement._SalesOrderItem.ItemBillingBlockReason    as BillingBlockReason,
      ProjectBillingElement._SalesOrderItem.SalesDocumentRjcnReason   as SalesDocumentRjcnReason
      //Add_LGA_21.08.26 - Fin

      // From I_SDBillingPlan ****************************************************************************************

      // From I_SDBillingPlanItem ************************************************************************************

      // From I_ProjectBillingRequest ********************************************************************************


}
