import pandas as pd
from mage_ai.settings.repo import get_repo_path
from mage_ai.io.config import ConfigFileLoader
from mage_ai.io.google_cloud_storage import GoogleCloudStorage
from os import path
if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_from_google_cloud_storage(*args, **kwargs):
    
    config_path = path.join(get_repo_path(), 'io_config.yaml')
    config_profile = 'default'

    bucket_name = 'real_estates_project'
    folder_prefix = 'real_estate_sales'

    gcs = GoogleCloudStorage.with_config(ConfigFileLoader(config_path, config_profile))

    file_keys = gcs.client.list_blobs(bucket_name, prefix=folder_prefix)
    
    print("Loading Files...")

    df = []
    for blob in file_keys:
        object_key = blob.name
        if object_key.endswith('.parquet'):
            df.append(gcs.load(bucket_name, object_key))

    if df:
        print("Merging Files...")
        return pd.concat(df, ignore_index=True)

    return None

@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'