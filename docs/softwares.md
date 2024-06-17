# Softwares used in the misc module

## [bgzip](http://www.htslib.org/doc/bgzip.html)
Compress a `.vcf` file using bgzip.

### :snake: Rule

#SNAKEMAKE_RULE_SOURCE__bgzip__bgzip#

#### :left_right_arrow: input / output files

#SNAKEMAKE_RULE_TABLE__bgzip__bgzip#

### :wrench: Configuration

#### Software settings (`config.yaml`)

#CONFIGSCHEMA__bgzip#

#### Resources settings (`resources.yaml`)

#RESOURCESSCHEMA__bgzip#

---

## [bedtools](https://bedtools.readthedocs.io)
Do arithmetic on BED files.

### :snake: Rule

#SNAKEMAKE_RULE_SOURCE__bed_tools__bedtools#

#### :left_right_arrow: input / output files

#SNAKEMAKE_RULE_TABLE__bedtools__bedtools#

### :wrench: Configuration

#### Software settings (`config.yaml`)

#CONFIGSCHEMA__bed_split#

#### Resources settings (`resources.yaml`)

#RESOURCESSCHEMA__bedtools#

---

## [ImageMagick](https://imagemagick.org)
Convert, edit, or compose bitmap images.

### :snake: Rule

#SNAKEMAKE_RULE_SOURCE__imagemagick__imagemagick#

#### :left_right_arrow: input / output files

#SNAKEMAKE_RULE_TABLE__imagemagick__imagemagick#

### :wrench: Configuration

#### Software settings (`config.yaml`)

#CONFIGSCHEMA__imagemagick#

#### Resources settings (`resources.yaml`)

#RESOURCESSCHEMA__imagemagick#

---

## [samtools](http://www.htslib.org/)
Samtools is used for indexing, and for extracting .fastq files from a .bam file for single-end and long reads

### :snake: Rule

#SNAKEMAKE_RULE_SOURCE__samtools__samtools#

#### :left_right_arrow: input / output files

#SNAKEMAKE_RULE_TABLE__samtools__samtools#

### :wrench: Configuration

#### Software settings (`config.yaml`)

#CONFIGSCHEMA__samtools#

#### Resources settings (`resources.yaml`)

#RESOURCESSCHEMA__samtools#

---

## [tabix](http://www.htslib.org/doc/tabix.html)
Creates an index file for faster processing of positions in a bgzipped vcf file.

### :snake: Rule

#SNAKEMAKE_RULE_SOURCE__tabix__tabix#

#### :left_right_arrow: input / output files

#SNAKEMAKE_RULE_TABLE__tabix__tabix#

### :wrench: Configuration

#### Software settings (`config.yaml`)

#CONFIGSCHEMA__tabix#

#### Resources settings (`resources.yaml`)

#RESOURCESSCHEMA__tabix#




