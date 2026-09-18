@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Billing Cockpit - Prelim. Billing Item'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_PRELIM_BILLING_ITEM
  as select from I_PrelimBillingDocumentItem

  association        to parent ZI_PRELIM_BILLING_HEADER as _PrelimBillingDocument  on  $projection.PrelimBillingDocument = _PrelimBillingDocument.PrelimBillingDocument

  association [0..1] to I_Batch                          as _Batch                  on  $projection.Plant   = _Batch.Plant
                                                                                    and $projection.Product = _Batch.Material
                                                                                    and $projection.Batch   = _Batch.Batch

  association [0..1] to I_BillingDocumentRequest         as _BillingDocumentRequest on  $projection.ReferenceSDDocument         = _BillingDocumentRequest.BillingDocumentRequest
                                                                                    and $projection.ReferenceSDDocumentCategory = 'EBDR'

  association [0..1] to I_EnterpriseProjectElement                 as _WBSElementBasicData           on  $projection.WBSElementInternalID = _WBSElementBasicData.WBSElementInternalID


{
  key PrelimBillingDocument,
  key PrelimBillingDocumentItem,

      SalesDocumentItemCategory,
      SalesDocumentItemType,
      ReturnItemProcessingType,
      CreatedByUser,
      CreationDate,
      CreationTime,
      ReferenceLogicalSystem,
      OrganizationDivision,
      Division,
      SalesOffice,
      Product,
      OriginallyRequestedMaterial,
      InternationalArticleNumber,
      PricingReferenceMaterial,
      Batch,
      ProductHierarchyNode,
      ProductGroup,
      AdditionalMaterialGroup1,
      AdditionalMaterialGroup2,
      AdditionalMaterialGroup3,
      AdditionalMaterialGroup4,
      AdditionalMaterialGroup5,
      ProductConfiguration,
      MaterialCommissionGroup,
      Plant,
      StorageLocation,
      SoldProduct,
      ReplacementPartType,
      MaterialGroupHierarchy1,
      MaterialGroupHierarchy2,
      PlantRegion,
      PlantCounty,
      PlantCity,
      BOMExplosion,
      MaterialDeterminationType,
      BillingDocumentItemText,
      ServicesRenderedDate,
      @Semantics.quantity.unitOfMeasure: 'BillingQuantityUnit'
      BillingQuantity,
      BillingQuantityUnit,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      BillingQuantityInBaseUnit,
      BaseUnit,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      MRPRequiredQuantityInBaseUnit,
      BillingToBaseQuantityDnmntr,
      BillingToBaseQuantityNmrtr,
      @Semantics.quantity.unitOfMeasure: 'ItemWeightUnit'
      ItemGrossWeight,
      @Semantics.quantity.unitOfMeasure: 'ItemWeightUnit'
      ItemNetWeight,
      ItemWeightUnit,
      @Semantics.quantity.unitOfMeasure: 'ItemVolumeUnit'
      ItemVolume,
      ItemVolumeUnit,
      BillToPartyCountry,
      BillToPartyRegion,
      BillingPlanRule,
      BillingPlan,
      BillingPlanItem,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      NetAmount,
      TransactionCurrency,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      GrossAmount,
      PricingDate,
      PriceDetnExchangeRate,
      cast(abs(PriceDetnExchangeRate) as abap.dec( 9, 5 ))  as AbsltPriceDetnExchangeRate,

      cast(case
             when PriceDetnExchangeRate < 0
             then 'X'
             else ' '
           end as abap.char( 1 ))         as PriceDetnExchRateIsIndrctQtan,

      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      PricingScaleQuantityInBaseUnit,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      TaxAmount,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      CostAmount,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      Subtotal1Amount,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      Subtotal2Amount,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      Subtotal3Amount,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      Subtotal4Amount,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      Subtotal5Amount,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      Subtotal6Amount,
      StatisticalValueControl,
      CashDiscountIsDeductible,
      CustomerConditionGroup1,
      CustomerConditionGroup2,
      CustomerConditionGroup3,
      CustomerConditionGroup4,
      CustomerConditionGroup5,
      ManualPriceChangeType,
      MaterialPricingGroup,
      StatisticsExchangeRate,
      cast(abs(StatisticsExchangeRate) as abap.dec( 9, 5 )) as AbsltStatisticsExchangeRate,

      cast(case
             when StatisticsExchangeRate < 0
             then 'X'
             else ' '
           end as abap.char( 1 ))         as StatisticsExchRateIsIndrctQtan,

      MainItemPricingRefMaterial,
      MainItemMaterialPricingGroup,
      TimeSheetOvertimeCategory,
      PricingRelevance,
      DepartureCountry,
      TaxJurisdiction,
      ProductTaxClassification1,
      ProductTaxClassification2,
      ProductTaxClassification3,
      ProductTaxClassification4,
      ProductTaxClassification5,
      ProductTaxClassification6,
      ProductTaxClassification7,
      ProductTaxClassification8,
      ProductTaxClassification9,
      ZeroVATRsn,
      TaxCode,
      TaxRateValidityStartDate,
      CountryOfOrigin,
      RegionOfOrigin,
      CommodityCode,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      EligibleAmountForCashDiscount,
      BusinessArea,
      ProfitCenter,
      OrderID,
      ProviderContract,
      ProviderContractItem,
      ControllingArea,
      ProfitabilitySegment_2                                         as ProfitabilitySegment,
      CostCenter,
      OriginSDDocument,
      OriginSDDocumentItem,
      PriceDetnExchangeRateDate,
      MatlAccountAssignmentGroup,
      ReferenceSDDocument,
      ReferenceSDDocumentItem,
      ReferenceSDDocumentCategory,
      SalesDocument,
      SalesDocumentItem,
      SalesSDDocumentCategory,
      HigherLevelItem,
      BillingDocumentItemInPartSgmt,
      ExternalReferenceDocument,
      BillingDocExtReferenceDocItem,
      SalesGroup,
      AdditionalCustomerGroup1,
      AdditionalCustomerGroup2,
      AdditionalCustomerGroup3,
      AdditionalCustomerGroup4,
      AdditionalCustomerGroup5,
      SDDocumentReason,
      RetailPromotion,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      RebateBasisAmount,
      VolumeRebateGroup,
      ItemIsRelevantForCredit,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      CreditRelatedPrice,
      SalesDeal,
      SalesPromotion,
      SalesOrderSalesDistrict,
      SalesOrderCustomerGroup,
      SalesOrderCustomerPriceGroup,
      SalesOrderPriceListType,
      SalesOrderSalesOrganization,
      SalesOrderDistributionChannel,
      SalesDocIsCreatedFromReference,
      ShippingPoint,
      ServiceDocumentType,
      ServiceDocument,
      ServiceDocumentItem,
      BusinessSolutionOrder,
      BusinessSolutionOrderItem,
      HigherLevelItemUsage,
      ShipToParty,

      _PrelimBillingDocument.PricingDocument,
      cast('PRELIMINARYBILLINGDOCUMENT' as abap.char( 26 ))          as SAPObjectTypeInUppercase,
      cast(PrelimBillingDocument as abap.char( 10 ))      as PrcgDocumentHostObjectNodeID,

      case
        when SalesSDDocumentCategory = 'C'
          then cast(SalesDocument as abap.char( 10 ))
        else ''
      end                                                            as SalesOrder,

      case
        when SalesSDDocumentCategory = 'C'
          then cast(SalesDocumentItem as abap.numc( 6 ))
        else abap.numc'000000'
      end                                                            as SalesOrderItem,

      case
        when ReferenceSDDocumentCategory = 'EBDR'
          then cast(ReferenceSDDocument as abap.char( 10 ))
        else ''
      end                                                            as BillingDocumentRequest,

      case
        when ReferenceSDDocumentCategory = 'EBDR'
          then cast(ReferenceSDDocumentItem as abap.numc( 6 ))
        else abap.numc'000000'
      end                                                            as BillingDocumentRequestItem,

      _BillingDocumentRequest.ReferenceDocument                      as ReferenceDocument,
      _BillingDocumentRequest.ReferenceDocSDDocCategory              as ReferenceDocSDDocCategory,

      case
        when _BillingDocumentRequest.ReferenceDocSDDocCategory = 'PBRQ'
          then cast(_BillingDocumentRequest.ReferenceDocument as abap.char( 40 ))
        else ''
      end                                                            as ProjectBillingRequest,

      WBSElementInternalID,
      _WBSElementBasicData.ProjectElement                      as WBSElementExternalID,
      _WBSElementBasicData._Project.Project                    as ProjectExternalID,

      @Consumption.hidden: true
      SalesOrganization,

      @Consumption.hidden: true
      BillingDocumentType,

      @Consumption.hidden: true
      _PrelimBillingDocument.IsRelevantForAccrual,

      @Semantics.booleanIndicator: true
      PricingIsIncomplete,
      
      /* Associations */
      _BillingDocumentRequest,
      _PrelimBillingDocument,
      _AdditionalCustomerGroup1,
      _AdditionalCustomerGroup2,
      _AdditionalCustomerGroup3,
      _AdditionalCustomerGroup4,
      _AdditionalCustomerGroup5,
      _AdditionalMaterialGroup1,
      _AdditionalMaterialGroup2,
      _AdditionalMaterialGroup3,
      _AdditionalMaterialGroup4,
      _AdditionalMaterialGroup5,
      _BaseUnit,
      _Batch,
      _BillingPlanRule,
      _BillingQuantityUnit,
      _BillToPartyCountry,
      _BillToPartyRegion,
      _BusinessArea,
      _BusinessAreaText,
      _ControllingArea,
      _CostCenter_2,
      _CountryOfOrigin,
      _CreatedByUser,
      _DepartureCountry,
      _Division,
      _HigherLevelItem,
      _ItemVolumeUnit,
      _ItemWeightUnit,
      _MainItemMaterialPricingGroup,
      _MainItemPricingRefMaterial,
      _MainItemPricingRefMatlText,
      _MaterialCommissionGroup,
      _MaterialPricingGroup,
      _MatlAccountAssignmentGroup,
      _OrganizationDivision,
      _OriginallyRequestedMaterial,
      _OriginallyRequestedMatlText,
      _Plant,
      _PlantRegion,
      _PricingReferenceMaterial,
      _PricingReferenceMaterialText,
      _PricingRelevance,
      _Product,
      _ProductGroup,
      _ProductHierarchyNode,
      _ProductText,
      _ProfitCenter,
      _ProviderContract,
      _ProviderContractItem,
      _ReferenceLogicalSystem,
      _ReferenceSDDocumentCategory,
      _RegionOfOrigin,
      _RetailPromotion,
      _SalesDeal,
      _SalesDocument,
      _SalesDocumentItem,
      _SalesDocumentItemCategory,
      _SalesDocumentItemType,
      _SalesGroup,
      _SalesOffice,
      _SalesOrderCustomerGroup,
      _SalesOrderCustomerPriceGroup,
      _SalesOrderDistributionChannel,
      _SalesOrderPriceListType,
      _SalesOrderSalesDistrict,
      _SalesOrderSalesOrganization,
      _SalesSDDocumentCategory,
      _SDDocumentReason,
      _ServiceDocumentType,
      _ShippingPoint,
      _ShippingPointText,
      _StatisticalValueControl,
      _StorageLocation,
      _SoldProduct,
      _TimeSheetOvertimeCat,
      _TransactionCurrency,
      _WBSElementBasicData,
      _ShipToParty    
}
