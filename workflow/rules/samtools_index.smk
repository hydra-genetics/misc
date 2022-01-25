__author__ = "Jonas Almlöf"
__copyright__ = "Copyright 2021, Jonas Almlöf"
__email__ = "jonas.almlof@scilifelab.uu.se"
__license__ = "GPL-3"


rule samtools_index:
    input:
        bam="{file}.bam",
    output:
        bai=temp("{file}.bam.bai"),
    params:
        extra=config.get("extra", {}).get("extra", ""),
    log:
        "{file}.bam.bai.log",
    benchmark:
        repeat(
            "{file}.bam.bai.benchmark.tsv",
            config.get("samtools_index", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("samtools_index", {}).get("threads", config["default_resources"]["threads"]),
    resources:
        mem_mb=config.get("samtools_index", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("samtools_index", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("samtools_index", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("samtools_index", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("samtools_index", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("samtools_index", {}).get("container", config["default_container"])
    conda:
        "../envs/samtools_index.yaml"
    message:
        "{rule}: Index {wildcards.file}.bam file"
    wrapper:
        "0.78.0/bio/samtools/index"
