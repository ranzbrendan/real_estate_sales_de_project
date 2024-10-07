import pyarrow as pa
import pyarrow.parquet as pq 
import os

if 'data_exporter' not in globals():
    from mage_ai.data_preparation.decorators import data_exporter

os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = "/home/src/personal-project-key.json"

bucket_name = 'real_estates_project'
project_id = 'crack-celerity-435208-v5'

table_name = "real_estate_sales"

root_path = f'{bucket_name}/{table_name}'

@data_exporter
def export_data(data, *args, **kwargs):
    data['year'] = data['date_recorded'].dt.strftime("%Y")
    data['year_month'] = data['date_recorded'].dt.strftime("%Y-%m")
    data['date_recorded'] = data['date_recorded'].dt.strftime("%Y-%m-%d")

    table = pa.Table.from_pandas(data)

    gcs = pa.fs.GcsFileSystem()

    pq.write_to_dataset(
        table,
        root_path=root_path,
        partition_cols=['year', 'year_month'],
        filesystem=gcs
    )