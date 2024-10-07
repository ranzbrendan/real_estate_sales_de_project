import io
import pandas as pd
import requests
if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data_from_api(*args, **kwargs):
    
    url = 'https://data.ct.gov/api/views/5mzw-sjtu/rows.csv?accessType=DOWNLOAD'
    response = requests.get(url)

    data_types = {
        'serial_number': pd.Int64Dtype(),
        'list_year': pd.Int64Dtype(),
        'town': pd.StringDtype(),
        'address': pd.StringDtype(),
        'assessed_value': pd.Float64Dtype(),
        'sale_amount': pd.Float64Dtype(),
        'sales_ratio': pd.Float64Dtype(),
        'property_type': pd.StringDtype(),
        'residential_type': pd.StringDtype(),
        'non_use_code': pd.StringDtype(),
        'assessor_remarks': pd.StringDtype(),
        'opm_remarks': pd.StringDtype(),
        'location': pd.StringDtype()
    }

    column_names = [
        'serial_number',
        'list_year',
        'date_recorded',
        'town',
        'address',
        'assessed_value',
        'sale_amount',
        'sales_ratio',
        'property_type',
        'residential_type',
        'non_use_code',
        'assessor_remarks',
        'opm_remarks',
        'location'
    ]

    parse_dates = ['date_recorded']

    df = pd.read_csv(io.StringIO(response.text), sep=',', names=column_names, header=0, parse_dates=parse_dates)

    return df


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
