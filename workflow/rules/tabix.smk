__author__ = "Martin Rippin"
__copyright__ = "Copyright 2022, Martin Rippin"
__email__ = "martin.rippin@scilifelab.uu.se"
__license__ = "GPL-3"


rule tabix:
    input:
        gz="{file}.gz",
    output:
        tbi=temp("{file}.gz.tbi"),
    params:
        extra=config.get("tabix", {}).get("extra", ""),
    log:
        "{file}.gz.tbi.log",
    benchmark:
        repeat(
            "{file}.gz.tbi.benchmark.tsv",
            config.get("tabix", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("tabix", {}).get("threads", config["default_resources"]["threads"])
    resources:
        threads=config.get("tabix", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("tabix", {}).get("time", config["default_resources"]["time"]),
        mem_mb=config.get("tabix", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("tabix", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("tabix", {}).get("partition", config["default_resources"]["partition"]),
    container:
        config.get("tabix", {}).get("container", config["default_container"])
    conda:
        "../envs/tabix.yaml"
    message:
        "{rule}: indexing {wildcards.file}.gz"
    wrapper:
        "0.85.0/bio/tabix"
