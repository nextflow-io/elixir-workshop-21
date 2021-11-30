.. _fourth-page:

*******************
The Nextflow config file
*******************

The information about the resources needed, the scheduler used and the container options can be stored within the **nextflow.config** file.
In this file we just include a number of single configuration files, each one for a different profile for different executors. 

.. literalinclude:: nextflow.config
   :language: groovy

Here you the single config files that are included by the main one and used depending on the different Nextflow parameter ``-profile`` 

Standard (default)
=======================

.. literalinclude:: ../conf/standard.config
   :language: groovy   

SGE
========
You can activate using this command line:

.. code-block:: console

  nextflow run nextflow-io/elixir-workshop-21 -r master -profile hpc_sge -with-docker

.. literalinclude:: ../conf/sge.config
   :language: groovy

SLURM
========
You can activate using this command line:

.. code-block:: console

  nextflow run nextflow-io/elixir-workshop-21 -r master -profile hpc_slurm -with-docker

.. literalinclude:: ../conf/slurm.config
   :language: groovy
   
RETRY EXAMPLE
==============

retry_example.config

You can activate using this command line:

.. code-block:: console

  nextflow run nextflow-io/elixir-workshop-21 -r master -profile retry -with-docker

.. literalinclude:: ../conf/retry_example.config
   :language: groovy
   :emphasize-lines: 15,16,17,18,19,22,23,24,25
   


AWS BATCH
=============
We can run our pipeline in AWS batch just by changing the following values in the **awsbatch.config** file:

.. literalinclude:: ../conf/awsbatch.config
   :language: groovy
   :emphasize-lines: 10,11

And then launching the pipeline from the local repository:

.. code-block:: console

  nextflow run nextflow run main.nf -with-docker  -profile cloud -bg > log 


