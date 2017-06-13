view: cost_and_usage {
  sql_table_name: aws_optimizer.cost_and_usage_raw ;;
  suggestions: no

  dimension: bill_billing_entity {
    type: string
    hidden: yes
    sql: ${TABLE}.bill_billingentity ;;
  }

  dimension_group: billing_period_end {
    view_label: "Billing Info"
    type: time
    timeframes: [time,date,week,month,year]
    sql: from_iso8601_timestamp(${TABLE}.bill_billingperiodenddate);;
  }

  dimension_group: billing_period_start {
    view_label: "Billing Info"
    type: time
    timeframes: [time,date,week,month,year]
    sql: from_iso8601_timestamp(${TABLE}.bill_billingperiodstartdate) ;;
  }

  dimension: billtype {
    label: "Type"
    view_label: "Billing Info"
    type: string
    sql: ${TABLE}.bill_billtype ;;
  }

  dimension: bill_invoiceid {
    type: string
    hidden: yes
    sql: ${TABLE}.bill_invoiceid ;;
  }

  dimension: bill_payeraccountid {
    type: string
    hidden: yes
    sql: ${TABLE}.bill_payeraccountid ;;
  }

  dimension: identity_lineitemid {
    type: string
    hidden: yes
    sql: ${TABLE}.identity_lineitemid ;;
  }

  dimension: identity_timeinterval {
    type: string
    hidden: yes
    sql: ${TABLE}.identity_timeinterval ;;
  }

  dimension: lineitem_availabilityzone {
    type: string
    hidden: yes
    sql: ${TABLE}.lineitem_availabilityzone ;;
  }

  dimension: lineitem_blendedcost {
    hidden: yes
    type: number
    sql: ${TABLE}.lineitem_blendedcost ;;
  }

  dimension: blended_rate {
    view_label: "Line Items (Individual Charges)"
    description: "The rate applied to this line item for a consolidated billing account in an organization."
    type: number
    sql: ${TABLE}.lineitem_blendedrate ;;
  }

  dimension: lineitem_currencycode {
    label: "Currency Code"
    view_label: "Line Items (Individual Charges)"
    type: string
    sql: ${TABLE}.lineitem_currencycode ;;
  }

  dimension: description {
    view_label: "Line Items (Individual Charges)"
    description: "A description of the pricing tier covered by this line item"
    type: string
    sql: ${TABLE}.lineitem_lineitemdescription ;;
  }


#### TYPES OF CHARGES ####

  dimension: type {
    view_label: "Line Items (Individual Charges)"
    description: "Fee is one-time RI expense for all-upfront or partial-upfront. RI Fee is recurring RI expense for partial-upfront and no-upfront RI expenses."
    type: string
    sql: ${TABLE}.lineitem_lineitemtype ;;
  }

  dimension: type_ri_fee_upfront {
    view_label: "Reserved Units"
    description: "Fee is one-time RI expense for all-upfront or partial-upfront."
    type: string
    sql: CASE WHEN ${TABLE}.lineitem_lineitemtype = "Fee" THEN "Fee" ELSE "Other" END ;;
  }

  dimension: type_ri_fee_on_demand {
    view_label: "Reserved Units"
    description: "RI Fee is recurring RI expense for partial-upfront and no-upfront RI expenses."
    type: string
    sql: CASE WHEN ${TABLE}.lineitem_lineitemtype = 'RIFee' THEN 'RI Fee' ELSE 'Other' END ;;
  }

  dimension: type_discounted_usage {
    view_label: "Reserved Units"
    description: "Describes the instance usage that recieved a matching RI discount benefit. It is added to the bill once a reserved instance experiences usage. Cost will always be zero because it's been accounted for with Fee and RI Fee."
    type: string
    sql: CASE WHEN ${TABLE}.lineitem_lineitemtype = "DiscountedUsage" THEN "Discounted Usage" ELSE "Other" END ;;
  }

  dimension: ri_line_item {
    label: "RI Line Item (Yes/No)"
    view_label: "Reserved Units"
    description: "Inlcudes all cost and usage information for Reserved Instances."
    type: string
    sql: CASE
         WHEN ${type} = 'DiscountedUsage' THEN 'RI Line Item'
         WHEN ${type} = 'RIFee' THEN 'RI Line Item'
         WHEN ${type} = 'Fee' THEN 'RI Line Item'
         ELSE 'Non RI Line Item'
        END ;;
  }



####

  dimension: normalization_factor {
    view_label: "Line Items (Individual Charges)"
    description: "Degree of instance size flexibility provided by RIs"
    type: number
    sql: ${TABLE}.lineitem_normalizationfactor ;;
  }

  dimension: lineitem_normalizedusageamount {
    hidden: yes
    type: number
    sql: ${TABLE}.lineitem_normalizedusageamount ;;
  }

  dimension: line_item_operation {
    label: "Operation"
    view_label: "Line Items (Individual Charges)"
    type: string
    sql: ${TABLE}.lineitem_operation ;;
  }

  dimension: product_code {
    description: "The AWS product/service being used"
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.lineitem_productcode ;;
  }

  dimension: lineitem_resourceid {
    type: string
    hidden: yes
    sql: ${TABLE}.lineitem_resourceid ;;
  }

  dimension: lineitem_taxtype {
    label: "Tax Type"
    view_label: "Line Items (Individual Charges)"
    type: string
    sql: ${TABLE}.lineitem_taxtype ;;
  }

  dimension: lineitem_unblendedcost {
    type: number
    hidden: yes
    sql: ${TABLE}.lineitem_unblendedcost ;;
  }

  dimension: unblended_rate {
    view_label: "Line Items (Individual Charges)"
    description: "The rate that this line item would have been charged for an unconsolidated account."
    type: number
    sql: ${TABLE}.lineitem_unblendedrate ;;
  }

  dimension: lineitem_usageaccountid {
    type: string
    hidden: yes
    sql: ${TABLE}.lineitem_usageaccountid ;;
  }

  dimension: lineitem_usageamount {
    type: number
    hidden: yes
    sql: ${TABLE}.lineitem_usageamount ;;
  }

  dimension_group: usage_end {
    view_label: "Line Items (Individual Charges)"
    type: time
    timeframes: [time,time_of_day,hour,date,week,day_of_week,month,month_name,year]
    sql: from_iso8601_timestamp(${TABLE}.lineitem_usageenddate) ;;
  }

  dimension_group: usage_start {
    view_label: "Line Items (Individual Charges)"
    type: time
    timeframes: [time,time_of_day,hour,date,week,day_of_week,month,month_name,year]
    sql: from_iso8601_timestamp(${TABLE}.lineitem_usagestartdate);;
  }

  dimension: lineitem_usagetype {
    label: "Usage Type"
    view_label: "Line Items (Individual Charges)"
    description: "The type of usage covered by this line item. If you paid for a Reserved Instance, the report has one line that shows the monthly committed cost, and multiple lines that show a charge of 0."
    type: string
    sql: ${TABLE}.lineitem_usagetype ;;
  }

  dimension: product_accountassistance {
    label: "Account Assistance"
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_accountassistance ;;
  }

  dimension: product_architecturalreview {
    label: "Architecture Review"
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_architecturalreview ;;
  }

  dimension: product_architecturesupport {
    label: "Architecture Support"
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_architecturesupport ;;
  }

  dimension: product_availability {
    label: "Availability"
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_availability ;;
  }

  dimension: product_bestpractices {
    hidden: yes
    type: string
    sql: ${TABLE}.product_bestpractices ;;
  }

  dimension: product_cacheengine {
    hidden: yes
    type: string
    sql: ${TABLE}.product_cacheengine ;;
  }

  dimension: product_caseseverityresponsetimes {
    hidden: yes
    type: string
    sql: ${TABLE}.product_caseseverityresponsetimes ;;
  }

  dimension: product_clockspeed {
    hidden: yes
    type: string
    sql: ${TABLE}.product_clockspeed ;;
  }

  dimension: product_currentgeneration {
    hidden: yes
    type: string
    sql: ${TABLE}.product_currentgeneration ;;
  }

  dimension: product_customerserviceandcommunities {
    hidden: yes
    type: string
    sql: ${TABLE}.product_customerserviceandcommunities ;;
  }

  dimension: product_databaseedition {
    label: "Database Edition"
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_databaseedition ;;
  }

  dimension: product_databaseengine {
    label: "Database Engine"
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_databaseengine ;;
  }

  dimension: product_dedicatedebsthroughput {
    label: "Dedicated EBS Throughput"
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_dedicatedebsthroughput ;;
  }

  dimension: product_deploymentoption {
    view_label: "Product Info"
    hidden: yes
    type: string
    sql: ${TABLE}.product_deploymentoption ;;
  }

  dimension: product_description {
    label: "Description"
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_description ;;
  }

  dimension: product_durability {
    label: "Durability"
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_durability ;;
  }

  dimension: product_ebsoptimized {
    hidden: yes
    type: string
    sql: ${TABLE}.product_ebsoptimized ;;
  }

  dimension: product_ecu {
    hidden: yes
    type: string
    sql: ${TABLE}.product_ecu ;;
  }

  dimension: endpoint_type {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_endpointtype ;;
  }

  dimension: engine_code {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_enginecode ;;
  }

  dimension: product_enhancednetworkingsupported {
    view_label: "Product Info"
    hidden: yes
    type: string
    sql: ${TABLE}.product_enhancednetworkingsupported ;;
  }

  dimension: execution_frequency {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_executionfrequency ;;
  }

  dimension: execution_location {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_executionlocation ;;
  }

  dimension: product_feecode {
    type: string
    hidden: yes
    sql: ${TABLE}.product_feecode ;;
  }

  dimension: product_feedescription {
    type: string
    hidden: yes
    sql: ${TABLE}.product_feedescription ;;
  }

  dimension: product_freequerytypes {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_freequerytypes ;;
  }

  dimension: free_trial {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_freetrial ;;
  }

  dimension: product_frequencymode {
    hidden: yes
    type: string
    sql: ${TABLE}.product_frequencymode ;;
  }

  dimension: from_location {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_fromlocation ;;
  }

  dimension: from_location_type {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_fromlocationtype ;;
  }

  dimension: product_group {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_group ;;
  }

  dimension: group_description {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_groupdescription ;;
  }

  dimension: product_includedservices {
    hidden: yes
    type: string
    sql: ${TABLE}.product_includedservices ;;
  }

  dimension: product_instancefamily {
    type: string
    hidden: yes
    sql: ${TABLE}.product_instancefamily ;;
  }

  dimension: instance_type {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_instancetype ;;
  }

  dimension: product_io {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_io ;;
  }

  dimension: product_launchsupport {
    hidden: yes
    type: string
    sql: ${TABLE}.product_launchsupport ;;
  }

  dimension: product_licensemodel {
    hidden: yes
    type: string
    sql: ${TABLE}.product_licensemodel ;;
  }

  dimension: location {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_location ;;
  }

  dimension: location_type {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_locationtype ;;
  }

  dimension: product_maximumstoragevolume {
    hidden: yes
    type: string
    sql: ${TABLE}.product_maximumstoragevolume ;;
  }

  dimension: product_maxiopsburstperformance {
    hidden: yes
    type: string
    sql: ${TABLE}.product_maxiopsburstperformance ;;
  }

  dimension: product_maxiopsvolume {
    hidden: yes
    type: string
    sql: ${TABLE}.product_maxiopsvolume ;;
  }

  dimension: max_throughput_volume {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_maxthroughputvolume ;;
  }

  dimension: product_maxvolumesize {
    type: string
    hidden: yes
    sql: ${TABLE}.product_maxvolumesize ;;
  }

  dimension: product_memory {
    type: string
    view_label: "Product Info"
    sql: ${TABLE}.product_memory ;;
  }

  dimension: product_messagedeliveryfrequency {
    type: string
    hidden: yes
    sql: ${TABLE}.product_messagedeliveryfrequency ;;
  }

  dimension: product_messagedeliveryorder {
    type: string
    hidden: yes
    sql: ${TABLE}.product_messagedeliveryorder ;;
  }

  dimension: product_minimumstoragevolume {
    type: string
    hidden: yes
    sql: ${TABLE}.product_minimumstoragevolume ;;
  }

  dimension: product_minvolumesize {
    hidden: yes
    type: string
    sql: ${TABLE}.product_minvolumesize ;;
  }

  dimension: network_performance {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_networkperformance ;;
  }

  dimension: operating_system {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_operatingsystem ;;
  }

  dimension: product_operation {
    label: "Operation"
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_operation ;;
  }

  dimension: product_operationssupport {
    type: string
    hidden: yes
    sql: ${TABLE}.product_operationssupport ;;
  }

  dimension: product_physicalprocessor {
    type: string
    hidden: yes
    sql: ${TABLE}.product_physicalprocessor ;;
  }

  dimension: product_preinstalledsw {
    type: string
    hidden: yes
    sql: ${TABLE}.product_preinstalledsw ;;
  }

  dimension: product_proactiveguidance {
    type: string
    hidden: yes
    sql: ${TABLE}.product_proactiveguidance ;;
  }

  dimension: product_processorarchitecture {
    type: string
    hidden: yes
    sql: ${TABLE}.product_processorarchitecture ;;
  }

  dimension: product_processorfeatures {
    type: string
    hidden: yes
    sql: ${TABLE}.product_processorfeatures ;;
  }

  dimension: productfamily {
    label: "Family"
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_productfamily ;;
  }


##### Innaccurate labeling on part of AWS - use product code instead ####

  dimension: product_name {
    type: string
    description: "Innaccurate labeling on part of AWS - use product code instead"
    hidden: yes
    view_label: "Product Info"
    sql: ${TABLE}.product_productname ;;
  }

#####
  dimension: product_programmaticcasemanagement {
    hidden: yes
    type: string
    sql: ${TABLE}.product_programmaticcasemanagement ;;
  }

  dimension: product_provisioned {
    hidden: yes
    type: string
    sql: ${TABLE}.product_provisioned ;;
  }

  dimension: product_queuetype {
    hidden: yes
    type: string
    sql: ${TABLE}.product_queuetype ;;
  }

  dimension: product_requestdescription {
    hidden: yes
    type: string
    sql: ${TABLE}.product_requestdescription ;;
  }

  dimension: product_requesttype {
    hidden: yes
    type: string
    sql: ${TABLE}.product_requesttype ;;
  }

  dimension: product_routingtarget {
    hidden: yes
    type: string
    sql: ${TABLE}.product_routingtarget ;;
  }

  dimension: product_routingtype {
    hidden: yes
    type: string
    sql: ${TABLE}.product_routingtype ;;
  }

  dimension: product_servicecode {
    hidden: yes
    type: string
    sql: ${TABLE}.product_servicecode ;;
  }

  dimension: product_sku {
    hidden: yes
    type: string
    sql: ${TABLE}.product_sku ;;
  }

  dimension: product_softwaretype {
    hidden: yes
    type: string
    sql: ${TABLE}.product_softwaretype ;;
  }

  dimension: product_storage {
    hidden: yes
    type: string
    sql: ${TABLE}.product_storage ;;
  }

  dimension: product_storageclass {
    hidden: yes
    type: string
    sql: ${TABLE}.product_storageclass ;;
  }

  dimension: product_storagemedia {
    hidden: yes
    type: string
    sql: ${TABLE}.product_storagemedia ;;
  }

  dimension: product_technicalsupport {
    hidden: yes
    type: string
    sql: ${TABLE}.product_technicalsupport ;;
  }

  dimension: tenancy {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_tenancy ;;
  }

  dimension: product_thirdpartysoftwaresupport {
    hidden: yes
    type: string
    sql: ${TABLE}.product_thirdpartysoftwaresupport ;;
  }

  dimension: to_location {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_tolocation ;;
  }

  dimension: to_location_type {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_tolocationtype ;;
  }

  dimension: training {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_training ;;
  }

  dimension: transfer_type {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_transfertype ;;
  }

  dimension: usage_family {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_usagefamily ;;
  }

  dimension: usage_type {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_usagetype ;;
  }

  dimension: product_vcpu {
    hidden: yes
    type: string
    sql: ${TABLE}.product_vcpu ;;
  }

  dimension: product_version {
    hidden: yes
    type: string
    sql: ${TABLE}.product_version ;;
  }

  dimension: product_volumetype {
    type: string
    hidden: yes
    sql: ${TABLE}.product_volumetype ;;
  }

  dimension: product_whocanopencases {
    hidden: yes
    type: string
    sql: ${TABLE}.product_whocanopencases ;;
  }

  dimension: pricing_leasecontractlength {
    hidden: yes
    type: string
    sql: ${TABLE}.pricing_leasecontractlength ;;
  }

  dimension: pricing_offeringclass {
    hidden: yes
    type: string
    sql: ${TABLE}.product_storageclass ;;
  }

  dimension: pricing_purchaseoption {
    hidden: yes
    type: string
    sql: ${TABLE}.pricing_purchaseoption ;;
  }

  dimension: pricing_publicondemandcost {
    hidden: yes
    type: string
    sql: ${TABLE}.pricing_publicondemandcost ;;
  }

  dimension: pricing_publicondemandrate {
    hidden: yes
    type: string
    sql: ${TABLE}.pricing_publicondemandrate ;;
  }

  dimension: pricing_term {
    hidden: yes
    type: string
    sql: ${TABLE}.pricing_term ;;
  }

  dimension: pricing_unit {
    hidden: yes
    type: string
    sql: ${TABLE}.pricing_unit ;;
  }

  dimension: reservation_availabilityzone {
    hidden: yes
    type: string
    sql: ${TABLE}.reservation_availabilityzone ;;
  }

  dimension: reservation_unitsperreservation {
    type: string
    hidden: yes
    sql: ${TABLE}.reservation_normalizedunitsperreservation ;;
  }

  dimension: reservation_numberofreservations {
    type: number
    hidden: yes
    sql: ${TABLE}.reservation_numberofreservations ;;
  }

  dimension: reservation_arn {
    view_label: "Reserved Units"
    description: "When an RI benefit discount is applied to a matching line item of usage, the ARN value in the reservation/ReservationARN column for the initial upfront fees and recurring monthly charges matches the ARN value in the discounted usage line items."
    type: string
    sql: ${TABLE}.reservation_reservationarn ;;
  }

  dimension: reservation_totalreservednormalizedunits {
    hidden: yes
    type: string
    sql: ${TABLE}.reservation_totalreservednormalizedunits ;;
  }

### SHOULD WORK, NO VALUES COMING THROUGH IN THE EXPORT
  dimension: reservation_totalreservedunits {
    description: "The total number of total number of hours across all reserved instances in the subscription."
    type: number
    hidden: yes
    sql: ${TABLE}.reservation_totalreservedunits ;;
  }

### FIX SO WE'RE NOT AGGREGATING OVER MEASURES
#   dimension: reservation_totalreservedunits {
#     description: "The total number of total number of hours across all reserved instances in the subscription."
#     type: number
#     hidden: yes
#     sql:(1.0 * ${reservation_numberofreservations}) * (1.0 * ${reservation_unitsperreservation}) ;;
#   }


  ### ENABLE FOR CUSTOM TAGS ###

  dimension: user_name {
    view_label: "Custom Resource Tagging"
    type: string
    sql: ${TABLE}.resourcetags_username ;;
  }

  dimension: user_cost_category {
    view_label: "Custom Resource Tagging"
    type: string
    sql: ${TABLE}.resourcetags_usercostcategory ;;
  }

  ### END EMNABLE FOR CUSTOM TAGS ###


  measure: count_line_items {
    view_label: "Line Items (Individual Charges)"
    type: count
  }



  ### LINE ITEM AGGREGATIONS ###

  measure: total_unblended_cost {
    view_label: "Line Items (Individual Charges)"
    description: "The cost of all aggregated line items after tiered pricing and discounted usage have been processed."
    type: sum
    sql: ${lineitem_unblendedcost} ;;
    value_format_name: usd_0
  }

  measure: average_unblended_rate {
    label: "Unblended Rate"
    view_label: "Line Items (Individual Charges)"
    description: "The average cost of all aggregated line items after tiered pricing and discounted usage have been processed."
    type: average
    sql: ${unblended_rate} ;;
    value_format_name: usd_0
  }

  measure: total_blended_cost {
    view_label: "Line Items (Individual Charges)"
    description: "How much all aggregated line items are charged to a consolidated billing account in an organization"
    type: sum
    sql: ${lineitem_blendedcost} ;;
    value_format_name: usd_0
  }

  measure: total_reserved_blended_cost {
    view_label: "Reserved Units"
    description: "How much all aggregated line items are charged to a consolidated billing account in an organization"
    type: sum
    sql: ${lineitem_blendedcost} ;;
    value_format_name: usd_0
    filters: {
      field: ri_line_item
      value: "RI Line Item"
    }
  }

  measure: total_non_reserved_blended_cost {
    view_label: "Reserved Units"
    description: "How much all aggregated line items are charged to a consolidated billing account in an organization"
    type: sum
    sql: ${lineitem_blendedcost} ;;
    value_format_name: usd_0
    filters: {
      field: ri_line_item
      value: "Non RI Line Item"
    }
  }
  measure: count_usage_months {
    hidden: yes
    type: count_distinct
    sql: ${usage_start_month} ;;
  }

  measure: average_blended_cost_all_time {
    view_label: "Line Items (Individual Charges)"
    description: "How much all aggregated line items are charged to a consolidated billing account in an organization"
    type: average
    sql: ${lineitem_blendedcost} ;;
    value_format_name: usd
  }

  measure: average_blended_cost_per_month {
    view_label: "Line Items (Individual Charges)"
    description: "How much all aggregated line items are charged to a consolidated billing account in an organization"
    type: number
    sql: ${total_blended_cost}/NULLIF(${count_usage_months},0) ;;
    value_format_name: usd_0
  }

  measure: average_blended_rate {
    label: "Blended Rate"
    view_label: "Line Items (Individual Charges)"
    description: "The average rate applied to all aggregated line items for a consolidated billing account in an organization."
    type: average
    sql: ${blended_rate} ;;
    value_format_name: usd
  }

  measure: total_usage_amount {
    view_label: "Line Items (Individual Charges)"
    description: "The amount of usage incurred by the customer. For all reserved units, use the Total Reserved Units column instead."
    type: sum
    sql: ${lineitem_usageamount} ;;
    value_format_name: decimal_0
  }


  ### PRODUCT SPECIFIC COST MEASURES ###

  measure: EC2_usage_amount {
    label: "EC2 Usage Amount"
    view_label: "Product Info"
    type: sum
    sql: ${lineitem_usageamount} ;;
    filters: {
      field: product_code
      value: "AmazonEC2"
    }
  }

  measure: cloudfront_usage_amount {
    view_label: "Product Info"
    type: sum
    sql: ${lineitem_usageamount} ;;
    filters: {
      field: product_code
      value: "AmazonCloudFront"
    }
  }

  measure: cloudtrail_usage_amount {
    view_label: "Product Info"
    type: sum
    sql: ${lineitem_usageamount} ;;
    filters: {
      field: product_code
      value: "AWSCloudTrail"
    }
  }
  measure: S3_usage_amount {
    view_label: "Product Info"
    type: sum
    sql: ${lineitem_usageamount} ;;
    filters: {
      field: product_code
      value: "AmazonS3"
    }
  }

  measure: redshift_usage_amount {
    view_label: "Product Info"
    type: sum
    sql: ${lineitem_usageamount} ;;
    filters: {
      field: product_code
      value: "AmazonRedshift"
    }
  }

  measure: rds_usage_amount {
    label: "RDS Usage Amount"
    view_label: "Product Info"
    type: sum
    sql: ${lineitem_usageamount} ;;
    filters: {
      field: product_code
      value: "AmazonRDS"
    }
  }

  measure: EC2_blended_cost {
    label: "EC2 Blended Cost"
    view_label: "Product Info"
    type: sum
    sql: ${lineitem_blendedcost} ;;
    value_format_name: usd_0
    filters: {
      field: product_code
      value: "AmazonEC2"
    }
  }

  measure: EC2_reserved_blended_cost {
    label: "EC2 Reserved Blended Cost"
    view_label: "Product Info"
    type: sum
    sql: ${lineitem_blendedcost} ;;
    value_format_name: usd_0
    filters: {
      field: product_code
      value: "AmazonEC2"
    }
    filters: {
      field: ri_line_item
      value: "RI Line Item"
    }
  }

  measure: EC2_non_reserved_blended_cost {
    label: "EC2 Non Reserved Blended Cost"
    view_label: "Product Info"
    type: sum
    sql: ${lineitem_blendedcost} ;;
    value_format_name: usd_0
    filters: {
      field: product_code
      value: "AmazonEC2"
    }
    filters: {
      field: ri_line_item
      value: "Non RI Line Item"
    }
  }

  measure: cloudfront_blended_cost {
    view_label: "Product Info"
    type: sum
    sql: ${lineitem_blendedcost} ;;
    value_format_name: usd_0
    filters: {
      field: product_code
      value: "AmazonCloudFront"
    }
  }

  measure: cloudtrail_blended_cost {
    view_label: "Product Info"
    type: sum
    sql: ${lineitem_blendedcost} ;;
    value_format_name: usd_0
    filters: {
      field: product_code
      value: "AWSCloudTrail"
    }
  }
  measure: S3_blended_cost {
    view_label: "Product Info"
    type: sum
    sql: ${lineitem_blendedcost} ;;
    value_format_name: usd_0
    filters: {
      field: product_code
      value: "AmazonS3"
    }
  }

  measure: redshift_blended_cost {
    view_label: "Product Info"
    type: sum
    sql: ${lineitem_blendedcost} ;;
    value_format_name: usd_0
    filters: {
      field: product_code
      value: "AmazonRedshift"
    }
  }

  measure: rds_blended_cost {
    label: "RDS Blended Cost"
    view_label: "Product Info"
    type: sum
    sql: ${lineitem_blendedcost} ;;
    value_format_name: usd_0
    filters: {
      field: product_code
      value: "AmazonRDS"
    }
  }



  ### RESERVED UNIT AGGREGATIONS ###

  measure: number_of_reservations {
    view_label: "Reserved Units"
    description: "The number of reservations covered by this subscription. For example, one Reserved Instance (RI) subscription may have four associated RI reservations."
    type: sum
    sql: ${reservation_numberofreservations} ;;
  }


### SHOULD WORK, NO VALUES COMING THROUGH IN THE EXPORT
#   measure: total_reserved_units_usage {
#     label: "Total Reserved Unit Usage (Hours Used)"
#     view_label: "Reserved Units"
#     description: "The total number of hours across all reserved instances in the subscription."
#     type: sum
#     sql: ${reservation_totalreservedunits} ;;
#   }

### UNTIL DISCREPENCY IS RESOLVED, USING A MANUAL CALCULATION
  measure: total_reserved_units_usage {
    label: "Total Reserved Unit Usage (Hours Used)"
    view_label: "Reserved Units"
    description: "The total number of hours across all reserved instances in the subscription."
    type: number
    sql: COALESCE(SUM(cost_and_usage_raw.reservation_numberofreservations),0) * COALESCE(SUM(cost_and_usage_raw.reservation_normalizedunitsperreservation),0 ) ;;
  }

  measure: total_normalized_reserved_units {
    view_label: "Reserved Units"
    description: "The value for Usage Amount multiplied by the value for Normalization Factor"
    type: sum
    sql: ${reservation_totalreservednormalizedunits} ;;
  }

  measure: units_per_reservation {
    label: "Units per Reservation (Hours Reserved)"
    view_label: "Reserved Units"
    description: "The number of usage units reserved by a single reservation in a given subscription, such as how many hours a single Amazon EC2 RI has reserved."
    type: sum
    sql: ${reservation_unitsperreservation} ;;
  }








}