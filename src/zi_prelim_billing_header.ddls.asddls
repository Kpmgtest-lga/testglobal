@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Billing Cokpit - Prelim. Billing Doc.'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_PRELIM_BILLING_HEADER
  as select from I_PrelimBillingDocument

  composition [0..*] of ZI_PRELIM_BILLING_ITEM  as _Item
  association [0..*] to I_PrelimBillingDocPartner      as _Partner on  $projection.PrelimBillingDocument            = _Partner.PrelimBillingDocument

  association [0..1] to I_PrelimBillingDocPartner      as _PrelimBillingDocBillToParty on  $projection.PrelimBillingDocument            = _PrelimBillingDocBillToParty.PrelimBillingDocument
                                                                                       and _PrelimBillingDocBillToParty.PartnerFunction = 'RE'

  association [0..1] to I_Customer                     as _BillToParty                 on  $projection.BillToParty = _BillToParty.Customer

  association [0..1] to ZTF_PRELIM_BILLING_REF_DOCS  as _RefDocConcat                  on $projection.PrelimBillingDocument = _RefDocConcat.PrelimBillingDocument

  association [0..1] to ZI_PBD_TO_BILLING_DOCUMENT  as _PBDToBillngDoc                  on $projection.PrelimBillingDocument = _PBDToBillngDoc.PreliminaryBillingDocument
  association [0..1] to ZI_PRELIM_BILLING_PROJECTS  as _ProjectsConcat                  on $projection.PrelimBillingDocument = _ProjectsConcat.PrelimBillingDocument
{
  key PrelimBillingDocument,

      SDDocumentCategory,
      BillingDocumentCategory,
      BillingDocumentType,

      CreatedByUser,
      CreationDate,
      CreationTime,
      LastChangeDate,
      LastChangeDateTime,
      @Semantics.dateTime: true
      dats_tims_to_tstmp(CreationDate,
                              CreationTime,
                              abap_system_timezone($session.client, 'NULL'),
                              $session.client, 'NULL')                                    as BillingDocCreationDateTime,

      LogicalSystem,
      SalesOrganization,
      DistributionChannel,
      Division,
      BillingDocumentDate,
      BillingDocCombinationCriteria,

      @Semantics.amount.currencyCode: 'TransactionCurrency'
      TotalTaxAmount,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      TotalNetAmount,

      @Semantics.amount.currencyCode: 'TransactionCurrency'
      cast(TotalNetAmount + TotalTaxAmount
           as abap.dec( 23, 2 ))                              as TotalGrossAmount,

      TransactionCurrency,

      StatisticsCurrency,
      CustomerPriceGroup,
      PriceListType,
      TaxDepartureCountry,
      VATRegistration,
      VATRegistrationOrigin,
      VATRegistrationCountry,
      HierarchyTypePricing,
      CustomerTaxClassification1,
      CustomerTaxClassification2,
      CustomerTaxClassification3,
      CustomerTaxClassification4,
      CustomerTaxClassification5,
      CustomerTaxClassification6,
      CustomerTaxClassification7,
      CustomerTaxClassification8,
      CustomerTaxClassification9,
      IsEUTriangularDeal,
      SDPricingProcedure,
      ShippingCondition,
      IncotermsVersion,
      IncotermsClassification,
      IncotermsTransferLocation,
      IncotermsLocation1,
      IncotermsLocation2,
      PayerParty,
      ContractAccount,
      CustomerPaymentTerms,
      PaymentMethod,
      PaymentReference,
      FixedValueDate,
      AdditionalValueDays,
      SEPAMandate,
      CompanyCode,
      CustomerAccountAssignmentGroup,
      AccountingExchangeRateIsSet,
      AccountingExchangeRate,
      cast(abs(AccountingExchangeRate) as abap.dec( 9, 5 )) as AbsltAccountingExchangeRate,

      cast(case
             when AccountingExchangeRate < 0
               then 'X'
               else ' '
           end as abap.char( 1 ))         as AcctgExchangeRateIsIndrctQtan,

      ExchangeRateDate,
      ExchangeRateType,
      DocumentReferenceID,
      AssignmentReference,
      DunningArea,
      DunningBlockingReason,
      DunningKey,

      InvoiceListType,
      InvoiceListBillingDate,
      SoldToParty,
      PartnerCompany,
      PurchaseOrderByCustomer,
      CustomerGroup,
      Country,
      CityCode,
      SalesDistrict,
      Region,
      County,
      CreditControlArea,
      CustomerRebateAgreement,

      PricingDocument,
      cast('PRELIMINARYBILLINGDOCUMENT' as abap.char( 30 ))          as SAPObjectTypeInUppercase,
      cast(PrelimBillingDocument as abap.char( 10 ))      as PrcgDocumentHostObjectNodeID,
      
      cast('PreliminaryBillingDocument' as sap_object_node_type_raw) as SAPObjectNodeType,

      OverallSDProcessStatus,
      BillingIssueType,
      OvrlItmGeneralIncompletionSts,

//      @VDM.lifecycle.status: #DEPRECATED
//      @VDM.lifecycle.successor: 'PricingIsIncomplete'
      OverallPricingIncompletionSts,
      PrelimBillingDocumentStatus,

//      @ObjectModel.foreignKey.association: '_PrelimBillgDocApprovalStatus'
      BillgProcDocApprovalStatus                                     as PrelimBillgDocApprovalStatus,

      PrelimBillgDocApprovalReason,

      IsRelevantForAccrual,

      _PrelimBillingDocBillToParty.Customer                          as BillToParty,
      _RefDocConcat.ConcatenatedReferenceDocs                        as ConcatenatedReferenceDocs,
      
      _ProjectsConcat.concatenatedprojects                           as ConcatenatedCustomerProjects,
      
      _PBDToBillngDoc.BillingDocument                                as BillingDocument,


      @Semantics.booleanIndicator: true
      PricingIsIncomplete,
      
      /* Associations */
      _Item,
      _Partner,

      _BillgProcDocApprovalStatus                                    as _PrelimBillgDocApprovalStatus,

      _BillingDocumentCategory,
      _BillingDocumentType,
      _BillingIssueType,
      _CityCode,
      _CompanyCode,
      _Country,
      _County_2,
      _CreatedByUser,
      _CreditControlArea,
      _CreditControlAreaText,
      _CustomerAccountAssgmtGroup,
      _CustomerGroup,
      _CustomerPaymentTerms,
      _CustomerPriceGroup,
      _DistributionChannel,
      _Division,
      _DunningArea,
      _DunningBlockingReason,
      _DunningKey,
      _EnhancedFields,
      _ExchangeRateType,
      _IncotermsClassification,
      _IncotermsVersion,
      _InvoiceListType,
      _LogicalSystem,
//      @VDM.lifecycle.status: #DEPRECATED
      _OverallPricingIncompletionSts,
      _OverallSDProcessStatus,
      _OvrlItmGeneralIncompletionSts,
      _PayerParty,
      _PaymentMethod,
      _PrelimBillgDocApprovalReason,
      _PrelimBillingDocumentStatus,
      _PriceListType,
      _Region,
      _SalesDistrict,
      _SalesOrganization,
      _SDDocumentCategory,
      _SDPricingProcedure,
      _ShippingCondition,
      _SoldToParty,
      _StatisticsCurrency,
      _TaxDepartureCountry,
      _TransactionCurrency,
      _VATRegistrationCountry,
      _VATRegistrationOrigin,
      _BillToParty,
      _RefDocConcat,
      _PBDToBillngDoc,
      _ProjectsConcat   
}
