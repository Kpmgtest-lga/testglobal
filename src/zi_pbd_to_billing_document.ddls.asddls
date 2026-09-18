@AbapCatalog.sqlViewName: 'ZPBD2BILLDOC'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Billing Doc from Preliminary Billing Doc'
@Metadata.ignorePropagatedAnnotations: true
define view ZI_PBD_TO_BILLING_DOCUMENT
  as select distinct from I_BillingDocumentBasic as PBD

  -- Join document flow to find the resulting billing document
  inner join I_SDDocumentMultiLevelProcFlow as Flow
    on  Flow.PrecedingDocument     = PBD.BillingDocument
    and Flow.SubsequentDocumentCategory = 'M'  -- 'M' = Invoice (standard billing doc)

  -- Join the resulting billing document header
  inner join I_BillingDocumentBasic as BilDoc
    on BilDoc.BillingDocument = Flow.SubsequentDocument

{
  -- Preliminary Billing Document fields
  key PBD.BillingDocument          as PreliminaryBillingDocument,
  key BilDoc.BillingDocument       as BillingDocument,
      PBD.BillingDocumentType      as PrelimBillingDocumentType,
      PBD.SoldToParty              as SoldToParty,
      PBD.BillingDocumentDate      as PrelimBillingDate,

  -- Resulting Billing Document fields

      BilDoc.BillingDocumentType   as BillingDocumentType,
      BilDoc.BillingDocumentDate   as BillingDocumentDate,
      BilDoc.TotalNetAmount        as TotalNetAmount,
      BilDoc.TransactionCurrency   as Currency

}
-- Restrict source to Preliminary Billing Documents only
where PBD.SDDocumentCategory        = 'PBD'   -- Preliminary Billing Document
  and PBD.BillingDocumentIsTemporary = ''      -- Exclude temporary documents
  and BilDoc.BillingDocumentIsTemporary = ''   -- Exclude temporary documents
  and BilDoc.BillingDocumentIsCancelled = ''   -- Exclude Cancelled documents
