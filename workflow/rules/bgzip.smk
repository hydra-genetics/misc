__author__ = "Jonas Almlöf"
__copyright__ = "Copyright 2021, Jonas Almlöf"
__email__ = "jonas.almlof@scilifelab.uu.se"
__license__ = "GPL-3"


rule bgzip:
    input:
        "{file}",
    output:
        temp("{file}.gz"),
    log:
        "{file}.gz.log",
    benchmark:
        repeat("{file}.gz.benchmark.tsv", config.get("bgzip", {}).get("benchmark_repeats", 1))
    threads: config.get("bgzip", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("bgzip", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("bgzip", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("bgzip", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("bgzip", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("bgzip", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("bgzip", {}).get("container", config["default_container"])
    conda:
        "../envs/bgzip.yaml"
    message:
        "{rule}: Bgzip {wildcards.file}"
    shell:
        "(bgzip -c {input} > {output}) &> {log}"
