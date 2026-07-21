{% snapshot patient_snapshot %}

{{
    config
    (
        strategy = 'timestamp',
        updated_at = 'CREATED_AT',
        unique_key = 'PATIENT_ID',
    )
}}

select * from {{source('patient','PATIENT_SRC')}}

{% endsnapshot %}