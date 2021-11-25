/*
*  Bowtie workflow and corresponding modules
*/

// Parameter definitions for both modules and workflow
params.CONTAINER = "quay.io/biocontainers/bowtie:1.2.3--py37hc9558a2_0"
params.OUTPUT = "bowtie_output"
params.LABEL = ""

/*
 * Bowtie module for indexing
 */
 
process Index {

    // indicates to use as a container the value indicated in the parameter
    container params.CONTAINER

    // show in the log which input file is analysed
    tag "${ref}"
    							
    input:
    path ref   							

    output:									
    tuple val("${ref}"), path ("${ref}*.ebwt")

    script:									
    """
        gunzip -c ${ref} > reference.fa
        bowtie-build reference.fa ${ref}
        rm reference.fa
    """
}

/*
 * Bowtie module for alignment
 */
 
process Align {

    // where to store the results and in which way
    publishDir(params.OUTPUT, pattern: '*.sam')

    // indicates to use as a container the value indicated in the parameter
    container params.CONTAINER

    // indicates to use as a label the value indicated in the parameter
    label (params.LABEL)


    tag "${reads}" 							

    input:
    tuple val(refname), path (ref_files)
    path reads  							

    output:									
    path "${reads}.sam", emit: samples_sam
    path "${reads}.log", emit: samples_log

    script:									
    """
        bowtie -p ${task.cpus} ${refname} -q ${reads} -S > ${reads}.sam 2> ${reads}.log
    """
}

/*
 * Bowtie workflow connecting both indexing and alignment
 */

workflow BOWTIE {
 
    // definition of input
    take: 
    ref_file
    input_reads

    // main part where we connect two modules, indexing and alignment
    main:
	bow_index = Index(ref_file)
	Align(bow_index, input_reads)
	
    // definition of workflow outputs derived from the alignment module outputs
    emit:
    	sam = Align.out.samples_sam
    	logs = Align.out.samples_log
}



