@EndUserText.label: 'Concatenated Customer Projects per Billing Doc.'
@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
define table function ZI_BILLING_DOC_PROJECTS
  returns {
    key client                : abap.clnt;
    key BillingDocument : vbeln;
        concatenatedprojectsbd : abap.char( 1333 );
  }
  implemented by method ZCL_TF_PRELIM_BILLING_REF_DOCS=>get_projects_bd;