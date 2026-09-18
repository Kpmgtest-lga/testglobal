@EndUserText.label: 'Concatenated Customer Projects per Pre.Billg.Doc'
@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
define table function ZI_PRELIM_BILLING_PROJECTS
  returns {
    key client                : abap.clnt;
    key PrelimBillingDocument : vbeln;
        concatenatedprojects : abap.char( 1333 );
  }
  implemented by method ZCL_TF_PRELIM_BILLING_REF_DOCS=>get_projects;