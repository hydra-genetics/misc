__author__ = "Jonas Almlöf"
__copyright__ = "Copyright 2021, Jonas Almlöf"
__email__ = "jonas.almlof@scilifelab.uu.se"
__license__ = "GPL-3"


import pandas
import yaml
from snakemake.utils import validate
from snakemake.utils import min_version

from hydra_genetics.utils.resources import load_resources
from hydra_genetics.utils.units import *
from hydra_genetics.utils.samples import *

min_version("6.8.0")


### Set and validate config file

if os.path.isfile("config/config.yaml"):

    configfile: "config/config.yaml"


elif os.path.isfile("config.yaml"):

    configfile: "config.yaml"


elif not workflow.overwrite_configfiles:
    raise FileExistsError("No config file found in working directory or passed as argument!")


validate(config, schema="../schemas/config.schema.yaml")
config = load_resources(config, config["resources"])
validate(config, schema="../schemas/resources.schema.yaml")


### Read and validate samples file

samples = pandas.read_table(config["samples"], dtype=str).set_index("sample", drop=False)
validate(samples, schema="../schemas/samples.schema.yaml")

### Read and validate units file

units = pandas.read_table(config["units"], dtype=str).set_index(["sample", "type", "flowcell", "lane"], drop=False)
validate(units, schema="../schemas/units.schema.yaml")

### Set wildcard constraints


wildcard_constraints:
    sample="|".join(get_samples(samples)),
    type="N|T|R",


def compile_output_list(wildcards):
    files = {
        "alignment/bwa_mem": [
            "bam.bai",
        ],
        "cnv_sv/cnvkit_diagram": [
            "png",
        ],
        "snv_indel/vardict": ["%s.vcf" % (bed) for bed in config["vardict"]["bed_files"].keys()] + ["vcf.gz.tbi"],
    }
    outputfiles = [
        "%s/%s_%s.%s" % (prefix, sample, unit_type, suffix)
        for prefix in files.keys()
        for sample in get_samples(samples)
        for unit_type in get_unit_types(units, sample)
        for suffix in files[prefix]
    ]
    return outputfiles
