import pandas as pd

if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    print(f"Preprocessing: rows with NULL date recorded: {data['date_recorded'].isna().sum()}")
    data = data[data['date_recorded'].notna()]

    return data

@test
def test_output(output, *args):
    assert output['date_recorded'].isna().sum() == 0, 'There are records with NULL date recorded'