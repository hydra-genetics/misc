__author__ = "Jonas Almlöf"
__copyright__ = "Copyright 2021, Jonas Almlöf"
__email__ = "jonas.almlof@scilifelab.uu.se"
__license__ = "GPL-3"


import pandas
import yaml
from snakemake.utils import validate
from snakemake.utils import min_version

from hydra_genetics.utils.units import *
from hydra_genetics.utils.samples import *
from hydra_genetics.utils.misc import *

min_version("6.8.0")


### Set and validate config file


configfile: "config.yaml"


with open(config["resources"]) as yml:
    config = merge(config, yaml.load(yml))


validate(config, schema="../schemas/config.schema.yaml")


### Read and validate samples file

samples = pandas.read_table(config["samples"], dtype=str).set_index("sample", drop=False)
validate(samples, schema="../schemas/samples.schema.yaml")

### Read and validate units file

units = pandas.read_table(config["units"], dtype=str).set_index(["sample", "type", "run", "lane"], drop=False)
validate(units, schema="../schemas/units.schema.yaml")

### Set wildcard constraints


wildcard_constraints:
    sample="|".join(get_samples(samples)),
    unit="N|T|R",


def compile_output_list(wildcards):
    return ["dummy.txt"]
