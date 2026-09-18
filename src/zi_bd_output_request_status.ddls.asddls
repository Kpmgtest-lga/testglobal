@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Billing Doc.Output Status - Print Basket'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_BD_OUTPUT_REQUEST_STATUS
  as select from I_BillingDocumentBasic as Header

    left outer join  ZI_OUTPUT_REQUEST_ITEM_MAX                  as _OutputReqItmEmail                on Header.BillingDocument = _OutputReqItmEmail.OutputControlApplicationObject
    left outer join  ZI_OUTPUT_REQ_ITM_PRINT_MAX                as _OutputReqItmPrint                on Header.BillingDocument = _OutputReqItmPrint.OutputControlApplicationObject

  composition [0..*] of ZI_Billng_Doc_Item_Basic  as _Item
    
  association [0..1] to ZI_BILLING_DOC_PROJECTS                     as _ProjectsConcatBD                 on $projection.BillingDocument = _ProjectsConcatBD.BillingDocument
{
  
  key   Header.BillingDocument,
        Header.SDDocumentCategory,
        Header.BillingDocumentCategory,
        Header.BillingDocumentType,
        Header.CreatedByUser,
        Header.CreationDate,
        Header.LastChangeDate,
        Header.BillingDocumentDate,
        Header.BillingDocumentIsCancelled,
        Header.CancelledBillingDocument,
        Header.InvoiceClearingStatus,
        Header.CompanyCode,
        Header.PurchaseOrderByCustomer,
        Header.Country,
        Header.DistributionChannel,
        Header.Division,
        Header.AccountingDocument,
        @Semantics.amount.currencyCode: 'TransactionCurrency'
        Header.TotalNetAmount,
        Header.PayerParty,
        Header.FiscalPeriod,
        Header.SalesOrganization,
        Header.OverallBillingStatus,
        Header.TransactionCurrency,
        @Semantics.amount.currencyCode: 'TransactionCurrency'
        Header.TotalTaxAmount,
        Header.TaxDepartureCountry,
        Header.VATRegistrationCountry,
        Header.VATRegistration,
        Header.BillingDocumentIsTemporary,
        cast (case 
                when _OutputReqItmEmail.OutputRequestItemStatus <> ' '
                then _OutputReqItmEmail.OutputRequestItemStatus
                else 'Not Relevant'
              end as abap.char(60))                                 as EmailStatus,
        _OutputReqItmEmail.CreationDateTime                         as EmailItemCreatedOn,
        _OutputReqItmEmail.LastChangeDateTime                       as EmailItemLastChangedOn,
        _OutputReqItmEmail.DispatchTime                             as EmailItemDispatchTime,
        cast (case 
                when _OutputReqItmPrint.OutputRequestItemStatus <> ' '
                then _OutputReqItmPrint.OutputRequestItemStatus
                else 'Not Relevant'
              end as abap.char(60))                                 as PrintStatus,
        _OutputReqItmPrint.CreationDateTime                         as PrintItemCreatedOn,
        _OutputReqItmPrint.LastChangeDateTime                       as PrintItemLastChangedOn,
        _OutputReqItmPrint.DispatchTime                             as PrintItemDispatchTime,
        _ProjectsConcatBD.concatenatedprojectsbd                    as ConcatenatedCustomerProjectBD,
        
//      Associations  
        _Item,
        _ProjectsConcatBD
}
where
   (Header.SDDocumentCategory = 'N'
   or Header.SDDocumentCategory = 'O'
   or Header.SDDocumentCategory = 'M')
   and (Header.BillingDocumentIsTemporary = ' ')
