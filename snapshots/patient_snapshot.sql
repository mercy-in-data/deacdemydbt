{% snapshot patient_snapshot %}


{{
    config
    (
        strategy = 'check',
        unique_key = 'PATIENT_ID',
        check_cols = ['PATIENT_NAME','PATIENT_CONTACT_NUMBER','PATIENT_EMAIL_ID','PATIENT_ADDRESS']
    )
}}

with raw as (
    select *, row_number() over(partition by PATIENT_ID order by CREATED_AT desc) as row_num from {{source('patient','PATIENT_SRC')}}
)
select PATIENT_ID, PATIENT_NAME, PATIENT_CONTACT_NUMBER , PATIENT_EMAIL_ID, PATIENT_ADDRESS from raw where row_num = 1

{% endsnapshot %}