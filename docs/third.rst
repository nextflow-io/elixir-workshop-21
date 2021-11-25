.. _third-page:

*******************
The Nextflow language
*******************

The main file
==============

We can use GitPod for looking and playing with the code. We need to log-in using github and open the project [... test this ...].

Then we go to workplace and load the **main.nf** file.

.. literalinclude:: ../main.nf
   :language: groovy


The params.config file
=======================

This file contains the definition of the pipeline parameters with some default values. They can be overridden by using **two hyphens** (as ``--reads`` or ``--reference`` etc).

.. literalinclude:: ../params.config
   :language: groovy

   

