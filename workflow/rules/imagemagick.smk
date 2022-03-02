__author__ = "Martin Rippin"
__copyright__ = "Copyright 2022, Martin Rippin"
__email__ = "martin.rippin@scilifelab.uu.se"
__license__ = "GPL-3"


rule imagemagick_convert:
    input:
        pdf="{file}.pdf",
    output:
        png=temp("{file}.png"),
    params:
        extra=config.get("imagemagick_convert", {}).get("extra", ""),
    log:
        "{file}.png.log",
    benchmark:
        repeat(
            "{file}.png.benchmark.tsv",
            config.get("imagemagick_convert", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("imagemagick_convert", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("imagemagick_convert", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("imagemagick_convert", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("imagemagick_convert", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("imagemagick_convert", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("imagemagick_convert", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("imagemagick_convert", {}).get("container", config["default_container"])
    conda:
        "../envs/imagemagick.yaml"
    message:
        "{rule}: Convert {wildcards.file}.pdf {wildcards.file}.png"
    shell:
        "(convert "
        "{params.extra} "
        "{input} "
        "{output}) &> {log}"
