# Nextflow DSL2 

Test pipeline for describing the potentialities of the Nextflow workflow orchestrator. 

## main.nf
This is the main script that uses the modules and subworkflows stored within the **subworkflows** folder. The parameters of this pipeline are indicated in the **params.config** file and the configuration in the **nextflow.config** file. A test dataset is within the **data** folder.

You can test it using either the [Docker](https://www.docker.com/) or the [Singularity](https://sylabs.io/guides/3.1/user-guide/index.html) container using the corresponding Nextflow parameters indicated by a **single hyphen**.

```
nextflow run main.nf -with-docker 
```

or

```
nextflow run main.nf -with-singularity
```


## params.config
Here we have the pipeline parameters. You can ovveride them via command line using **two hyphens**:

```
nextflow run main.nf -with-docker --reads "PATH/*.fastq.gz" --reference PATH/myref.fa.gz --output OUTPATH

```

## nextflow.config 
This file defines the resources needed for the pipeline execution together with a number of platform-specific configurations, called profiles that are stored as single files within a folder named **conf**. 

## conf
This folder has a number of files, each one describing a single Nextflow configuration for each profile that can be chosen using the Nextflow parameter ```-profile```

- standard: local computer
- hpc_sge: [SGE](https://en.wikipedia.org/wiki/Oracle_Grid_Engine)
- hpc_slurm: [slurm](https://en.wikipedia.org/wiki/Slurm_Workload_Manager)
- cloud: [AWS batch](https://aws.amazon.com/es/batch/)

Example: 

```
nextflow run main.nf -with-docker -profile slurm
```

## subworkflows
This folder contains four Nextflow modules and a sub-workflow in three files:

- **fastqc** module in the file **fastqc.nf**
- **multiqc** module in the file **multiqc.nf**
- **bowtie** sub-workflow, **Index** and **Align** modules in the file **bowtie.nf**






