#!/usr/bin/env nextflow

/*
 * Copyright (c) 2021, Centre for Genomic Regulation (CRG).
 *
 *   This file is part of 'CRG_course_NextFlow'.
 *
 *   CRG_course_NextFlow is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   CRG_course_NextFlow is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with CRG_course_NextFlow.  If not, see <http://www.gnu.org/licenses/>.
 */


/* 
 * This code enables the new Nextflow dsl (domain-specific language). 
 */

nextflow.enable.dsl=2


/* 
 * NextFlow test pipe, Those are comments
 * @authors
 * Luca Cozzuto <lucacozzuto@gmail.com>
 * 
 */

/*
 * Input parameters: read pairs, reference and output
 * The configuration is in nextflow.config file 
 * Params are stored in the params.config file 
 */

// this prevents a warning of undefined parameter
params.help             = false

// this prints the input parameters
log.info """
BIOCORE@CRG - N F TESTPIPE  
=============================================
reads                           : ${params.reads}
reference                       : ${params.reference}
output				: ${params.output}
"""

// this prints the help in case you use --help parameter in the command line and it stops the pipeline
if (params.help) {
    log.info 'This is the Biocore\'s Nextflow test pipeline'
    log.info 'Please define reads, reference and output!\n'
    log.info 'Enjoy!'
    log.info '\n'
    exit 1
}

/*
 * Defining the output folders.
 */
fastqcOutputFolder    = "${params.output}/ouptut_fastqc"
alnOutputFolder       = "${params.output}/ouptut_aln"
multiqcOutputFolder   = "${params.output}/ouptut_multiQC"

/*
 * Defining the module / subworkflow path, and iclude the elements
 */
subwork_folder = "${projectDir}/subworkflows/"
include { fastqc } from "${subwork_folder}/fastqc" addParams(OUTPUT: fastqcOutputFolder)
include { BOWTIE } from "${subwork_folder}/bowtie" addParams(OUTPUT: alnOutputFolder, LABEL:'twocpus')
include { multiqc } from "${subwork_folder}/multiqc" addParams(OUTPUT: multiqcOutputFolder)


/*
 * Read the files indicated by the wildcard                   
 */
Channel
    .fromPath( params.reads )  								                           
    .ifEmpty { error "Cannot find any reads matching: ${params.reads}" }                                  // if empty, complains
    .set {reads} 											  // make the channel "reads"

/*
 *  Read the reference file. If empty, complains                  
 */
reference = file(params.reference)
if (!reference.exists()) { error "Cannot find any reference file matching: ${params.reference}" }  

/*
 * MAIN workflow definition.
 * 1) Execute fastqc on input reads in parallel
 * 2) Execute BOWTIE sub-workflow with both indexing and alignment 
 * 3) Gather the results from both fastqc module and bowtie sub-workflow and execute the multiQC module
 */
workflow {
	fastqc_out = fastqc(reads)
	map_res = BOWTIE(reference, reads)
	multiqc(fastqc_out.mix(map_res.logs).collect())
	map_res.sam.view()                                 // view the output sam files
	map_res.logs.view()                                // view the output log files
}


/*
 *  When complete print a message                  
 */
workflow.onComplete { 
	println ( workflow.success ? "\nDone! Open the following report in your browser --> ${multiqcOutputFolder}/multiqc_report.html\n" : "Oops .. something went wrong" )
}

