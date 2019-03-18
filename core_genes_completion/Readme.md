# Completing Missing Core Genes Alleles Using Machine Learning

Researchers in the areas of medicine and computers have found certain methods to identify, for a given bacterium, a list of its core genes.
This list is called a scheme. One of those schemes is CGMLST. Every bacteria specie has a different CGMLST scheme.
Every core gene that we look for in the given bacteria appears in different variants called Alleles which are commonly enumerated.

Noise in the process of bacteria DNA sequencing causes loss of sequencing information. As a result, in many cases, some of the core genes won't be found in the sequencing process, meaning that for these genes, alleles won't be found. That is in spite of the fact that for most if not all of them the core genes actually exist in the inspected bacterium. Due to that problem (and possibly others) CGMLST scheme is not practically used, and stays in the boundaries of research.

This project target is to find a machine learning model that predicts the missing alleles of a single core gene based on all other core genes data in the bacteria CGMLST scheme.

Staph. Aureus bacterium was picked due to the fact it has high medical importance, has large number of available public samples and a known CGMLST schemes (containing 1861 core genes).

## Data Gathering & Filtering

Over 4000 assembly sequences that were deposited as Staphylococus Aureus bacteria were download from [NCBI Database]([http://google.com](https://www.ncbi.nlm.nih.gov/genome/genomes/154?))

Data was filtered based on:

* Genus and specie identification (Making sure that assembly data is indeed belong to St. Aur).
* Bioinformatic Quality control, involving checking contig number and length, number of missing nucleotides (number of "N"s in the sequence).

## Data Exploration

Bioinformatic tools were used to identify the 1861 core genes alleles found in the remaining filtered samples.\
Due to high dimensionality (dimension is 1860 as number of core genes) and number of examples it's hard to visualize the data in some interesting form other than the table structure.

Public bacteria samples are uploaded to NCBI from all over the world, as a result there's a large variance in bacteria sequencing methods and quality.

The next figure shows there few hundred samples with over 100 of their core genes\
 data missing: due to bad sequencing quality:

![Number of samples by not available core genes](/images/project_samples_NA.png)

The CGMLST was tailor made in order to classify bacteria based on the allele version found in each of the core genes, hence we expect to find all core genes in any bacteria samples.\
The next figure help us validate the CGMLST scheme by showing how many of  the missing core genes in our samples are due to poor sequencing quality or due to 'bad' core genes selection by scheme creators:

![Number of samples by NA genes](/images/core_genes_by_NA.PNG)

We have found that there are 30 columns with more than 25% missing data. We chose not to drop them, since we're not sure what biological meaning dropping them might have.\
However, this may shed light about the scheme correctness and redundancy characteristics.\

In total few hundreds samples were dropped based on core genes analysis.

## Methodology

### Random Forest

Random Forest classifier was focused at first. Among all ML tools taken into consideration, RF requires minimal number of parameters to tune, and is known for handling well with categorical variables in high dimension problems.\
RF training first consists on parameters tuning performed by running RF with the default parameters i.e. 500 trees and square root of the number of features = 43 variables to get first estimation.
RF has two important parameters: the number of trees in the forest and the number of random variables that each tree construction is based on.\

As a general rule, as the number of trees increases we expect to
get better results. Random forest uses bagging (picking a sample of observations rather than all of them)
and random subspace method (picking a sample of features rather than all of them to grow a tree).\
When the number of observations is large, but the number of trees is too small, then some observations will be
predicted only once or even not at all. If the number of predictors is large but the number of trees is too
small, then some features can (theoretically) be missed in all subspaces used. Both cases result in the
decrease of random forest predictive power. But the last is a rather extreme case, since the selection of subspace is performed at each node.

### Neural Network classifier

Later we compared RF results with Neural Network classifier results,
NN has one important parameter: number of neurons.\
There isn't optimal method to define the number of neurons. There are however several empirical rules of thumb.\
The most mentioned rule was using the mean of the inputs entered to the network (number of neurons in the input layer)\
 and the outputs (number of neurons in the output layer), assuming 3 layers network (which indeed suits the problem).

###  K-means classifier

K-means, an unsupervised learning algorithm that seeks if the data has some sort of structure, has one important parameter: number of clusters.\
The goal performing k-means is to use data projection to clustering to gain insights regarding the problem. k-means clustering aims to partition n observations into k clusters in which each observation belongs to the cluster with the nearest mean.\
This results in a partitioning of the data space into Voronoi cells. If the distance metric system (by which examples are assigned to clusters) is correct, then achieving optimal k is slightly ambiguous and often depends on the desired clustering resolution of the user.\
In addition, increasing k without penalty will always reduce the amount of error in the resulting clustering, to the extreme case of zero error if each data point is considered its own cluster.\
 Intuitively then, the optimal choice of k will strike a balance between maximum compression of the data using a single cluster, and maximum accuracy by assigning each data point to its own cluster. If an appropriate value of k is not apparent from prior knowledge of the properties of the data set, it must be chosen somehow, e.g. by cross validation.

 ## Results

 ### Random Forest
 Running RF with the default parameters provided 0.024% OOB error. Then 10-fold cross validation was used to test number of trees an variables parameters:  100, 200, …, 1000 trees and 35, 40, 43, 50 variables:

![Number of samples by NA genes](/images/random_forest_result.PNG)
40 different combinations of number of trees and number of features were tested. The best results colored green have 99.7313% accuracy, or only 11 examples misclassified out of the 4093.\
Higher number of trees will give only negligible improvement in accuracy, but will elongate severely computation time and memory used.

### Neural Network

![Number of samples by NA genes](/images/NN_result.PNG)

As a general rule, as the number of neurons increases, the predictions accuracy increases as well. After 20 neurons, accuracy decreases, probably due to overfitting.\
NN best results using cross validation as a measure were 96.70169% accuracy, achieved using 20 neurons.\
Using 16 neurons, one can get 96.57953% accuracy (paying 0.1222% accuracy) and saving 30% computation time.

### K-means classifier

K-means best results using the ratio of the inter cluster squared distances and outer cluster squared distances was achieved using k = 33:
![Number of samples by NA genes](/images/k_means_1.PNG)


Unfortunately, the gradual decreased depicted in the graph does not bring interesting conclusions. It is natural that the higher the number of clusters the lower the inner-outer distances ratio.\
We can see however sharper improvement in lower values of k, which may be an indication for getting closer to the natural clusters separation of the problem. Since we cannot rely here on the inner-outer ratio measure we turn now to a second measure: ratio between DB(BOULDIN, 1979) and DUNN(Dunn, 1973) measures.\
K-means best results using DB and Dunn measures were achieved using k = 10. Following is a graph of three measures as a function of the parameter k value. The mixed measure is the quotient of the Dunn measure divided by the DB measure:

![Number of samples by NA genes](/images/k_means_2.PNG)