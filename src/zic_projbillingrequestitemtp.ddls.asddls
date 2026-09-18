@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Copy of R_ProjectBillingRequestItemTP'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZIC_ProjBillingRequestItemTP
    as select from I_ProjectBillingRequestItem   as ProjectBillingRequestItem
        left outer to one join I_PrjBlgElmEntrJrnlEntrLink as _PrjBlgElmEntrJrnlEntrLinkTP on ProjectBillingRequestItem.ProjBillgElmntEntrItmUUID = _PrjBlgElmEntrJrnlEntrLinkTP.ProjBillgElmntEntrItmUUID

      association [0..1]  to I_ProjectBillingElementEntry   as _ProjectBillingElementEntryTP on  $projection.ProjBillgElmntEntrItmUUID = _ProjectBillingElementEntryTP.ProjBillgElmntEntrItmUUID
      association         to I_ProjectBillingRequest as _ProjectBillingRequestTP      on  $projection.ProjectBillingRequestUUID = _ProjectBillingRequestTP.ProjectBillingRequestUUID
      association [0..1]  to I_ProjectBillingCategory         as _ProjectBillingCategory       on  $projection.projectbillingcategory = _ProjectBillingCategory.ProjectBillingCategory

      association [1..*]  to I_ProjectBillingCategoryText     as _ProjectBillingCategoryText   on  $projection.projectbillingcategory = _ProjectBillingCategoryText.ProjectBillingCategory
      association [0..1]  to ZIC_SUPPORT__PBR_BILLPLANLINK    as _PrjBlgElmEntrBillgPlnLink    on $projection.ProjBillgElmntEntrItmUUID = _PrjBlgElmEntrBillgPlnLink.ProjBillgElmntEntrItmUUID
      association [0..1]  to I_CustomerMaterial_2             as _CustomerMaterial             on  $projection.salesorganization   = _CustomerMaterial.SalesOrganization
                                                                                           and $projection.distributionchannel = _CustomerMaterial.DistributionChannel
                                                                                           and $projection.soldtoparty         = _CustomerMaterial.Customer
                                                                                           and $projection.Material            = _CustomerMaterial.Product
      association [0..1]  to I_BillingControlCategoryText     as _BillingControlCategoryText   on  $projection.BillingControlCategory   = _BillingControlCategoryText.BillingControlCategory
                                                                                           and _BillingControlCategoryText.Language = $session.system_language
      association [0..1]  to I_TimeSheetOvertimeCatText       as _TimeSheetOvertimeCatText     on  $projection.TimeSheetOvertimeCategory = _TimeSheetOvertimeCatText.TimeSheetOvertimeCategory
                                                                                           and _TimeSheetOvertimeCatText.Language    = $session.system_language
      association [0..1]  to I_ProjectBillingReqStatusText     as _BillingReqStatusText   on  $projection.projectbillingrequeststatus   = _BillingReqStatusText.ProjectBillingRequestStatus
                                                                                           and _BillingReqStatusText.Language = $session.system_language

      association [0..1]  to I_SalesOrderBillingPlanItem     as _SalesDocumentBillingPlanItem   on  $projection.BillingPlan   = _SalesDocumentBillingPlanItem.BillingPlan
                                                                                                and $projection.BillingPlanItem    = _SalesDocumentBillingPlanItem.BillingPlanItem
                                                                                                and $projection.SalesDocument    = _SalesDocumentBillingPlanItem.SalesOrder
                                                                                                
      association [0..1]  to I_SalesOrderBillingPlan     as _SalesDocumentBillingPlan   on  $projection.BillingPlan   = _SalesDocumentBillingPlan.BillingPlan
                                                                                                and $projection.SalesDocument    = _SalesDocumentBillingPlan.SalesOrder                                                                                                



{
  key ProjectBillingRequestItem.ProjectBillingRequestItemUUID                                                                        as ProjectBillingRequestItemUUID,
      ProjectBillingRequestItem.ProjectBillingRequestUUID                                                                            as ProjectBillingRequestUUID,
      ProjectBillingRequestItem.ProjBillgElmntEntrItmUUID                                                                            as ProjBillgElmntEntrItmUUID,
      ProjectBillingRequestItem.ProjectBillingElementUUID                                                                            as ProjectBillingElementUUID,

      ProjectBillingRequestItem.SalesDocumentItem                                                                                    as SalesDocumentItem,
      ProjectBillingRequestItem.BillingPlan                                                                                          as BillingPlan,
      ProjectBillingRequestItem.BillingPlanItem                                                                                      as BillingPlanItem,
      @Semantics.quantity.unitOfMeasure: 'QuantityUnit'
      ProjectBillingRequestItem.ToBePostponedQuantity                                                                                as ToBePostponedQuantity,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      ProjectBillingRequestItem.ToBePostponedAmtInTransacCrcy                                                                        as ToBePostponedAmtInTransacCrcy,
      @Semantics.amount.currencyCode: 'ProjectCurrency'
      ProjectBillingRequestItem.ToBePostponedAmtInProjectCrcy                                                                        as ToBePostponedAmtInProjectCrcy,
      @Semantics.amount.currencyCode: 'GlobalCurrency'
      ProjectBillingRequestItem.ToBePostponedAmtInGlobalCrcy                                                                         as ToBePostponedAmtInGlobalCrcy,
      @Semantics.quantity.unitOfMeasure: 'QuantityUnit'
      ProjectBillingRequestItem.ToBeWrittenOffQuantity                                                                               as ToBeWrittenOffQuantity,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      ProjectBillingRequestItem.ToBeWrittenOffAmtInTransCrcy                                                                         as ToBeWrittenOffAmtInTransCrcy,
      @Semantics.amount.currencyCode: 'ProjectCurrency'
      ProjectBillingRequestItem.ToBeWrittenOffAmtInProjectCrcy                                                                       as ToBeWrittenOffAmtInProjectCrcy,
      @Semantics.amount.currencyCode: 'GlobalCurrency'
      ProjectBillingRequestItem.ToBeWrittenOffAmtInGlobalCrcy                                                                        as ToBeWrittenOffAmtInGlobalCrcy,
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      ProjectBillingRequestItem.BillableRevenueAmtInDocCrcy                                                                          as BillableRevenueAmtInDocCrcy,
      @Semantics.user.createdBy: true
      ProjectBillingRequestItem.ProjBillgReqItmCrtedByUser                                                                           as ProjBillgReqItmCrtedByUser,
      @Semantics.systemDateTime.createdAt: true
      ProjectBillingRequestItem.ProjBillgReqItmCrtedAtDteTme                                                                         as ProjBillgReqItmCrtedAtDteTme,
      @Semantics.user.lastChangedBy: true
      ProjectBillingRequestItem.ProjBillgReqItmLastChgdBy                                                                            as ProjBillgReqItmLastChgdBy,
      @Semantics.systemDateTime.lastChangedAt: true
      ProjectBillingRequestItem.ProjBillgReqItmLastChgdDteTme                                                                        as ProjBillgReqItmLastChgdDteTme,
      ProjectBillingRequestItem.ServicesRenderedDate                                                                                 as ServicesRenderedDate,
      @Semantics.quantity.unitOfMeasure: 'QuantityUnit'
      ProjectBillingRequestItem.ToBeBilledQuantity                                                                                   as ToBeBilledQuantity,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      ProjectBillingRequestItem.ToBeBilledAmtInTransCrcy                                                                             as ToBeBilledAmtInTransCrcy,
      @Semantics.amount.currencyCode: 'ProjectCurrency'
      ProjectBillingRequestItem.ToBeBilledAmtInProjCurrency                                                                          as ToBeBilledAmtInProjCurrency,
      @Semantics.amount.currencyCode: 'GlobalCurrency'
      ProjectBillingRequestItem.ToBeBilledAmtInGlobCurrency                                                                          as ToBeBilledAmtInGlobCurrency,

      @Semantics.quantity.unitOfMeasure: 'QuantityUnit'
      ProjectBillingRequestItem.OpenQuantity                                                                                         as OpenQuantity,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      ProjectBillingRequestItem.OpenAmountInTransCrcy                                                                                as OpenAmountInTransCrcy,
      @Semantics.amount.currencyCode: 'ProjectCurrency'
      ProjectBillingRequestItem.OpenAmountInProjectCurrency                                                                          as OpenAmountInProjectCurrency,
      @Semantics.amount.currencyCode: 'GlobalCurrency'
      ProjectBillingRequestItem.OpenAmountInGlobalCurrency                                                                           as OpenAmountInGlobalCurrency,
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      ProjectBillingRequestItem.OpenRevenueAmtInDocCrcy                                                                              as OpenRevenueAmtInDocCrcy,
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      ProjectBillingRequestItem.NetPriceAmountInDocCrcy                                                                              as NetPriceAmountInDocCrcy,
      ProjectBillingRequestItem.NetPriceQuantity                                                                                     as NetPriceQuantity,
      ProjectBillingRequestItem.NetPriceQuantityUnit                                                                                 as NetPriceQuantityUnit,
      ProjectBillingRequestItem.Material                                                                                             as Material,
//      ProjectBillingRequestItem._Material._Text.MaterialName,

      ProjectBillingRequestItem.TransactionCurrency,
      ProjectBillingRequestItem.ProjectCurrency,
      ProjectBillingRequestItem.QuantityUnit,
      ProjectBillingRequestItem.GlobalCurrency,
      ProjectBillingRequestItem.DocumentCurrency,

      ProjectBillingRequestItem.ManualBillgSelForPrjBlgReqItem                                                                       as ManualBillgSelForPrjBlgReqItem,
      ProjectBillingRequestItem.ProjectBillingRequestItemDesc                                                                        as ProjectBillingRequestItemDesc,
      ProjectBillingRequestItem.ProjBillgReqItmSourceType                                                                            as ProjBillgReqItmSourceType,
      ProjectBillingRequestItem.ProjBillgTransfCostQtyCode,
      ProjectBillingRequestItem.ProjBillgItmValIsNotActualCost,
      ProjectBillingRequestItem.ProjBillingRequestItemLongText                                                                       as ProjBillingRequestItemLongText,

      _ProjectBillingRequestTP.SalesDocument                                                                                         as SalesDocument,
      _ProjectBillingElementEntryTP._ProjectBillingElement._SalesOrder.SalesOrganization,
      _ProjectBillingElementEntryTP._ProjectBillingElement._SalesOrder.DistributionChannel,
      _ProjectBillingElementEntryTP._ProjectBillingElement._SalesOrder.SoldToParty,
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_ProjectBillingCategory',
                     element: 'ProjectBillingCategory' }
        }]
      @ObjectModel.foreignKey.association: '_ProjectBillingCategory'
      @Consumption.hidden: true
      _ProjectBillingRequestTP.ProjectBillingCategory,
      _ProjectBillingRequestTP.ProjectBillingRequestStatus, //needed in where condition in C-view
      @ObjectModel.text.element: null
//      _ProjectBillingRequestTP.UserID, //needed in where condition in ManagePBR C-view
      concat(ltrim(_ProjectBillingRequestTP.SalesDocument,'0'), concat('/',ltrim(ProjectBillingRequestItem.SalesDocumentItem,'0')) ) as SalesOrderItemConcatenatedID,

      case
        when _PrjBlgElmEntrJrnlEntrLinkTP._GLAccountLineItemRawData._BillableControl.BillableControl is null then 'BILLABLE'
        else _PrjBlgElmEntrJrnlEntrLinkTP._GLAccountLineItemRawData._BillableControl.BillableControl //'NON_BILL'
      end                                                                                                                            as BillingControlCategory,
      _PrjBlgElmEntrJrnlEntrLinkTP._GLAccountLineItemRawData.PersonnelNumber                                                                                   as PersonnelNumber,
      _PrjBlgElmEntrJrnlEntrLinkTP.Ledger,
      _PrjBlgElmEntrJrnlEntrLinkTP.CompanyCode,
      _PrjBlgElmEntrJrnlEntrLinkTP.FiscalYear,
      _PrjBlgElmEntrJrnlEntrLinkTP.LedgerGLLineItem                                                                                  as LedgerGLLineItem,
      _PrjBlgElmEntrJrnlEntrLinkTP.AccountingDocument                                                                                as AccountingDocument,
      cast ( concat( ltrim(_PrjBlgElmEntrJrnlEntrLinkTP.AccountingDocument,'0'),
              concat(concat('/',_PrjBlgElmEntrJrnlEntrLinkTP.LedgerGLLineItem),
              concat('/',_PrjBlgElmEntrJrnlEntrLinkTP.FiscalYear) ) ) as abap.char(40) )                                       as JournalEntrySemanticKey,

      _PrjBlgElmEntrJrnlEntrLinkTP._GLAccountLineItemRawData.
        _OriginCostCtrActivityType[1:ValidityStartDate <= $session.system_date and ValidityEndDate >= $session.system_date ].
        _Text[1:Language = $session.system_language].CostCtrActivityTypeDesc                                                         as CostCtrActivityTypeDesc, //C-view
      _PrjBlgElmEntrJrnlEntrLinkTP._GLAccountLineItemRawData.WorkItem                                                                as WorkItem, //C-view
      _PrjBlgElmEntrJrnlEntrLinkTP._GLAccountLineItemRawData.TimeSheetOvertimeCategory                                               as TimeSheetOvertimeCategory,

      $session.user_date                                                                                                             as UserLocalDate,

      //Required for making visibility within get_features. Cannot be moved to C-view
//      _SalesDocumentBillingPlan.BillingPlanServiceStartDate              as BillingPlanServiceStartDate,
//      _PrjBlgElmEntrBillgPlnLink._ProjectBillingElementEntry._ProjectBillingElement._SalesOrderItem._ItemBillingPlan.BillingPlanServiceEndDate                as BillingPlanServiceEndDate,
      _PrjBlgElmEntrBillgPlnLink._ProjectBillingElementEntry._ProjectBillingElement._SalesOrderItem._ItemBillingPlan.BillingPlanUsageCategory   as BillingMethod,


      @Semantics.amount.currencyCode: 'TransactionCurrency'
      case
      when _ProjectBillingElementEntryTP.OriginalTotalQuantity is not initial
      then cast(
          cast(
            ( curr_to_decfloat_amount( _ProjectBillingElementEntryTP.OriginalAmountInTransacCrcy ) / _ProjectBillingElementEntryTP.OriginalTotalQuantity )
          as abap.dec(23,2) )
        as abap.curr(23,2) )
      else cast( 0 as abap.curr(23,2) )
      end                                                                                                                            as BaseUnitActualCost,

      _PrjBlgElmEntrJrnlEntrLinkTP._GLAccountLineItemRawData.PartnerCostCenter                                                       as PartnerCostCenter,



      //Associations
      _TimeSheetOvertimeCatText,
      _BillingControlCategoryText,
      _CustomerMaterial,
      _ProjectBillingRequestTP,
      _ProjectBillingElementEntryTP,      
      _ProjectBillingCategory,
      _ProjectBillingCategoryText,
      _BillingReqStatusText,
      _SalesDocumentBillingPlanItem,
      _SalesDocumentBillingPlan
}
