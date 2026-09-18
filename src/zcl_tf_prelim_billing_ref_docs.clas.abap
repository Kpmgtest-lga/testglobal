CLASS zcl_tf_prelim_billing_ref_docs DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.

    CLASS-METHODS get_ref_docs
      FOR TABLE FUNCTION ZTF_PRELIM_BILLING_REF_DOCS.
    CLASS-METHODS get_projects
      FOR TABLE FUNCTION ZI_PRELIM_BILLING_PROJECTS.
    CLASS-METHODS get_projects_bd
      FOR TABLE FUNCTION ZI_BILLING_DOC_PROJECTS.
      "AMDP OPTIONS CDS SESSION CLIENT CURRENT
ENDCLASS.

CLASS ZCL_TF_PRELIM_BILLING_REF_DOCS IMPLEMENTATION.

METHOD get_ref_docs
  BY DATABASE FUNCTION FOR HDB
  LANGUAGE SQLSCRIPT
  OPTIONS READ-ONLY
  USING ZI_PRELIM_BILLING_ITEM_RAW.



  -- Step 1: Pre-deduplicate reference documents per billing document
  lt_distinct =
    SELECT DISTINCT
      prelimbillingdocument,
      referencedocument
    FROM ZI_PRELIM_BILLING_ITEM_RAW
    WHERE referencedocument IS NOT NULL
      AND referencedocument <> '';

  -- Step 2: Count unique items and build concatenated string per billing document
  lt_counted =
    SELECT
      prelimbillingdocument,
      COUNT(*)                                     AS item_count,
      STRING_AGG( referencedocument, ', '
                  ORDER BY referencedocument )     AS concatenated
    FROM :lt_distinct
    GROUP BY prelimbillingdocument;

-- Step 3: Apply threshold logic show list if <= 3, show "N items" if > 3
    RETURN
    SELECT
      session_context( 'CDS_CLIENT' )              AS client,
      prelimbillingdocument          AS PrelimBillingDocument,
      CAST( CASE
              WHEN item_count > 3
              THEN TO_NVARCHAR( item_count ) || ' items'
              ELSE concatenated
            END
            AS NVARCHAR( 1333 ) )                  AS concatenatedreferencedocs
    FROM :lt_counted;

ENDMETHOD.
METHOD get_projects
  BY DATABASE FUNCTION FOR HDB
  LANGUAGE SQLSCRIPT
  OPTIONS READ-ONLY
  USING ZI_PRELIM_BILLING_ITEM_RAW.

  -- Step 1: Pre-deduplicate WBS Elements per billing document
  lt_distinct_wbs =
    SELECT DISTINCT
      prelimbillingdocument,
      ProjectExternalID
    FROM ZI_PRELIM_BILLING_ITEM_RAW
    WHERE ProjectExternalID IS NOT NULL
      AND ProjectExternalID <> '';


  -- Step 2: Count unique items and build concatenated string WBS per billing document
  lt_counted_wbs =
    SELECT
      prelimbillingdocument,
      COUNT(*)                                     AS item_count,
      STRING_AGG( ProjectExternalID, ', '
                  ORDER BY ProjectExternalID )     AS concatenated
    FROM :lt_distinct_wbs
    GROUP BY prelimbillingdocument;


-- Step 3: Apply threshold logic show list if <= 3, show "N items" if > 3
    RETURN
    SELECT
      session_context( 'CDS_CLIENT' )              AS client,
      prelimbillingdocument          AS PrelimBillingDocument,
      CAST( CASE
              WHEN item_count > 2
              THEN TO_NVARCHAR( item_count ) || ' items'
              ELSE concatenated
            END
            AS NVARCHAR( 1333 ) )                  AS concatenatedprojects
    FROM :lt_counted_wbs;


ENDMETHOD.

METHOD get_projects_bd
  BY DATABASE FUNCTION FOR HDB
  LANGUAGE SQLSCRIPT
  OPTIONS READ-ONLY
  USING ZI_BILLNG_DOC_ITEM_BASIC_RAW.

  -- Step 1: Pre-deduplicate WBS Elements per billing document
  lt_distinct_wbs_bd =
    SELECT DISTINCT
      billingdocument,
      ProjectExternalID
    FROM ZI_BILLNG_DOC_ITEM_BASIC_RAW
    WHERE ProjectExternalID IS NOT NULL
      AND ProjectExternalID <> '';


  -- Step 2: Count unique items and build concatenated string WBS per billing document
  lt_counted_wbs_bd =
    SELECT
      billingdocument,
      COUNT(*)                                     AS item_count,
      STRING_AGG( ProjectExternalID, ', '
                  ORDER BY ProjectExternalID )     AS concatenated
    FROM :lt_distinct_wbs_bd
    GROUP BY billingdocument;


-- Step 3: Apply threshold logic show list if <= 3, show "N items" if > 3
    RETURN
    SELECT
      session_context( 'CDS_CLIENT' )              AS client,
      billingdocument          AS BillingDocument,
      CAST( CASE
              WHEN item_count > 2
              THEN TO_NVARCHAR( item_count ) || ' items'
              ELSE concatenated
            END
            AS NVARCHAR( 1333 ) )                  AS concatenatedprojectsbd
    FROM :lt_counted_wbs_bd;


ENDMETHOD.
ENDCLASS.
