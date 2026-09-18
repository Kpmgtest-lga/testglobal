@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Project Billing Req Item - Custom Projection'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true

define view entity ZIC_ProjBillReqItem
  provider contract transactional_query
  as projection on I_ProjectBillingReqItemTP_2
//define view entity ZIC_ProjBillReqItem as projection on I_ProjectBillingReqItemTP_2
{
  key ProjectBillingRequestItemUUID,
      ProjBillgElmntEntrItmUUID,
      ProjectBillingRequestUUID,
      ProjectBillingElementUUID,
      SalesDocumentItem,
      ProjBillingRequestItemLongText,
      @Semantics.quantity.unitOfMeasure: 'QuantityUnit'
      ToBePostponedQuantity,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      ToBePostponedAmtInTransacCrcy,
      @Semantics.amount.currencyCode: 'ProjectCurrency'
      ToBePostponedAmtInProjectCrcy,
      @Semantics.amount.currencyCode: 'GlobalCurrency'
      ToBePostponedAmtInGlobalCrcy,
      @Semantics.quantity.unitOfMeasure: 'QuantityUnit'
      ToBeWrittenOffQuantity,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      ToBeWrittenOffAmtInTransCrcy,
      @Semantics.amount.currencyCode: 'ProjectCurrency'
      ToBeWrittenOffAmtInProjectCrcy,
      @Semantics.amount.currencyCode: 'GlobalCurrency'
      ToBeWrittenOffAmtInGlobalCrcy,
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      BillableRevenueAmtInDocCrcy,
      ProjBillgReqItmCrtedByUser,
      ProjBillgReqItmCrtedAtDteTme,
      ProjBillgReqItmLastChgdBy,
      ProjBillgReqItmLastChgdDteTme,
      ServicesRenderedDate,
      @Semantics.quantity.unitOfMeasure: 'QuantityUnit'
      ToBeBilledQuantity,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      ToBeBilledAmtInTransCrcy,
      @Semantics.amount.currencyCode: 'ProjectCurrency'
      ToBeBilledAmtInProjCurrency,
      @Semantics.amount.currencyCode: 'GlobalCurrency'
      ToBeBilledAmtInGlobCurrency,
      @Semantics.quantity.unitOfMeasure: 'QuantityUnit'
      OpenQuantity,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      OpenAmountInTransCrcy,
      @Semantics.amount.currencyCode: 'ProjectCurrency'
      OpenAmountInProjectCurrency,
      @Semantics.amount.currencyCode: 'GlobalCurrency'
      OpenAmountInGlobalCurrency,
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      OpenRevenueAmtInDocCrcy,
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      NetPriceAmountInDocCrcy,
      @Semantics.quantity.unitOfMeasure: 'NetPriceQuantityUnit'
      NetPriceQuantity,
      NetPriceQuantityUnit,
      Material,
      TransactionCurrency,
      GlobalCurrency,
      ProjectCurrency,
      DocumentCurrency,
      QuantityUnit,
      @ObjectModel.sapObjectNodeTypeReference: 'ProjBillgReqItmSourceType'
      ProjBillgReqItmSourceType,
      ProjectBillingRequestItemDesc,
      @ObjectModel.sapObjectNodeTypeReference: 'ProjectBillingCategory'
      ProjectBillingCategory,
      @ObjectModel.sapObjectNodeTypeReference: 'ManualBillgSelForPrjBlgReqItem'
      ManualBillgSelForPrjBlgReqItem,
      _PrjBlgElmEntrJrnlEntrLink._GLAccountLineItemRawData.PersonnelNumber as PersonnelNumber,
      _PrjBlgElmEntrJrnlEntrLink.AccountingDocument as JournalEntry,
      _PrjBlgElmEntrJrnlEntrLink.LedgerGLLineItem as JournalEntryItem,
      _PrjBlgElmEntrJrnlEntrLink.FiscalYear as JournalEntryFiscalYear,
//      cast ( concat( ltrim(_PrjBlgElmEntrJrnlEntrLink.AccountingDocument,'0'),
//      concat(concat('/',_PrjBlgElmEntrJrnlEntrLink.LedgerGLLineItem),
//      concat('/',_PrjBlgElmEntrJrnlEntrLink.FiscalYear) ) ) as abap.char(40) )                                       as JournalEntrySemanticKey,
      _PrjBlgElmEntrJrnlEntrLink._GLAccountLineItemRawData._OriginCostCtrActivityType[1:ValidityStartDate <= $session.system_date and ValidityEndDate >= $session.system_date ]._Text[1:Language = $session.system_language].CostCtrActivityTypeDesc as ActivityType,
//      _PrjBlgElmEntrJrnlEntrLink._ProjectBillingElementEntry._ProjectBillingElement._WBSElement.WBSElementExternalID as BillingElement,
//      _PrjBlgElmEntrJrnlEntrLink._ProjectBillingElementEntry._ProjectBillingElement._WBSElement.WBSDescription as BillingElementDescription,
//      _PrjBlgElmEntrJrnlEntrLink._ProjectBillingElementEntry._WBSElement.WBSElementExternalID,
      _PrjBlgElmEntrJrnlEntrLink._GLAccountLineItemRawData.WorkItem,
//      @Semantics.amount.currencyCode: 'TransactionCurrency'
//      _PrjBlgElmEntrJrnlEntrLink._ProjectBillingElementEntry.OriginalAmountInTransacCrcy / _PrjBlgElmEntrJrnlEntrLink._ProjectBillingElementEntry.OriginalTotalQuantity as CostRate,
//      @Semantics.amount.currencyCode: 'TransactionCurrency'
//      case
//      when _PrjBlgElmEntrJrnlEntrLink._ProjectBillingElementEntry.OriginalTotalQuantity <> 0
//      then cast(
//          cast(
//            ( curr_to_decfloat_amount( _PrjBlgElmEntrJrnlEntrLink._ProjectBillingElementEntry.OriginalAmountInTransacCrcy ) / _PrjBlgElmEntrJrnlEntrLink._ProjectBillingElementEntry.OriginalTotalQuantity )
//          as abap.dec(23,2) )
//        as abap.curr(23,2) )
//      else cast( 0 as abap.curr(23,2) )
//      end
//       case
//        when _PrjBlgElmEntrJrnlEntrLink._GLAccountLineItemRawData.BillableControl = '' then 'BILLABLE'
//        else _PrjBlgElmEntrJrnlEntrLink._GLAccountLineItemRawData.BillableControl //'NON_BILL'
//      end as BillingControlCategory,
      _PrjBlgElmEntrJrnlEntrLink._ProjectBillingElementEntry._ProjectBillingElement._SalesOrderItem._ItemBillingPlan.BillingPlanUsageCategory,
      @Semantics.amount.currencyCode: 'TransactionCurrency'         
      _PrjBlgElmEntrJrnlEntrLink._ProjectBillingElementEntry.OriginalAmountInTransacCrcy,
      @Semantics.quantity.unitOfMeasure: 'QuantityUnit'
      _PrjBlgElmEntrJrnlEntrLink._ProjectBillingElementEntry.OriginalTotalQuantity,
      _PrjBlgElmEntrJrnlEntrLink._GLAccountLineItemRawData.TimeSheetOvertimeCategory,
      _PrjBlgElmEntrJrnlEntrLink._ProjectBillingElementEntry._ProjectBillingElement._SalesOrderItem.MaterialByCustomer,
      /*Associations */
      _PrjBlgElmEntrJrnlEntrLink,
//      ProjectBillingRequestItem._ProjectBillingRequest,
      _TransactionCurrency,
      _ProjectCurrency,
      _GlobalCurrency,
      _DocumentCurrency,
      _ProjectBillingCategory,
      _ProjBillgReqItmSrceType,
      @Consumption.hidden: true
      _TransactionCurrencyText,
      @Consumption.hidden: true
      _ProjectCurrencyText,
      @Consumption.hidden: true
      _GlobalCurrencyText,
      @Consumption.hidden: true
      _DocumentCurrencyText,
      @Consumption.hidden: true
      _ProjectBillingCategoryText,
      @Consumption.hidden: true
      _ProjBillgReqItmSrceTypeText
    
      /* Associations */
//    _ProjectBillingRequestTP : redirected to parent I_ProjectBillingRequestTP_2
}
