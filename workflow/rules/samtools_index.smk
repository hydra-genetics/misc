__author__ = "Jonas Almlöf"
__copyright__ = "Copyright 2021, Jonas Almlöf"
__email__ = "jonas.almlof@scilifelab.uu.se"
__license__ = "GPL-3"


rule samtools_index:
    input:
        "{file}.bam",
    output:
        "{file}.bam.bai",
    log:
        "{file}.bam.bai.log",
    benchmark:
        repeat(
            "{file}.bam.bai.benchmark.tsv",
            config.get("samtools_index", {}).get("benchmark_repeats", 1),
        )
    container:
        config.get("samtools_index", {}).get("container", "default_container")
    threads: config.get("samtools_index", config["default_resources"])["cores"]
    conda:
        "../envs/{rule}.yaml"
    message:
        "{rule}: Index {wildcards.file} bam file"
    wrapper:
        "0.78.0/bio/samtools/index"
