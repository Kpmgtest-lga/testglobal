@EndUserText.label: 'Concatenated Ref.Docs per Pre.Billg.Doc'
@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
define table function ZTF_PRELIM_BILLING_REF_DOCS
//  with parameters
//    @Environment.systemField: #CLIENT
//    p_client : abap.clnt
  returns {
    key client                : abap.clnt;
    key PrelimBillingDocument : vbeln;
        ConcatenatedReferenceDocs : abap.char( 1333 );
  }
  implemented by method ZCL_TF_PRELIM_BILLING_REF_DOCS=>get_ref_docs;