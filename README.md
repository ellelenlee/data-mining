# Data-Mining Projects

## Project A: Clustering

A set of observations on a number of silhouettes is related to different type of vehicles, using a set of features extracted from the silhouette. Each vehicle may be viewed from one of many different angles. The features were extracted from the silhouettes by the HIPS (Hierarchical Image Processing System) extension BINATTS, which extracts a combination of scale independent features utilising  both classical moments based measures such as scaled variance, skewness and kurtosis about the major/minor axes and heuristic measures such as hollows, circularity, rectangularity and compactness. Four model vehicles were used for the experiment: a double decker bus, Cheverolet van, Saab and an Opel Manta. This particular combination of vehicles was chosen with the expectation that the bus, van and either one of the cars would be readily distinguishable, but it would be more difficult to distinguish between the cars.
One dataset (vehicles.xls) is available and has 846 observations/samples. There are 19 variables/features, all numerical and one nominal defining the class of the objects.

Description of attributes:
1.	Comp: Compactness
2.	Circ: Circularity
3.	D.Circ: Distance Circularity
4.	Rad.Ra: Radius ratio
5.	Pr.Axis.Ra: pr.axis aspect ratio
6.	Max.L.Ra: max.length aspect ratio
7.	Scat.Ra: scatter ratio
8.	Elong: elongatedness
9.	Pr.Axis.Rect: pr.axis rectangularity
10.	Max.L.Rect: max.length rectangularity
11.	Sc.Var.Maxis: scaled variance along major axis
12.	Sc.Var.maxis: scaled variance along minor axis
13.	Ra.Gyr: scaled radius of gyration
14.	Skew.Maxis: skewness about major axis
15.	Skew.maxis: skewness about minor axis
16.	Kurt.maxis: kurtosis about minor axis
17.	Kurt.Maxis: kurtosis about major axis
18.	Holl.Ra: hollows ratio
19.	Class: type of cars

In this clustering part I used the first 18 attributes to your calculations.

### Task 1. Partitioning Clustering

* Pre-processing data
* Find the ideal number of clusters
* K-means with the best two clusters
* Find the mean of each attribute for the winner cluster
* Check consistency of the results 
* Investigate alternative input configurations


### Task 2. Hierarchical Clustering
* Perform hierarchical clustering (for single, complete, etc)
* Create a dendrogram
* Check the cophenetic correlation and discuss the findings
* Coorplot function and discuss the findings

## Project B: Forecasting 

Time series analysis can be used in a multitude of business applications for forecasting a quantity into the future and explaining its historical patterns. Exchange rate is the currency rate of one country expressed in terms of the currency of another country. In the modern world, exchange rates of the most successful countries are tending to be floating. This system is set by the foreign exchange market over supply and demand for that particular currency in relation to the other currencies. Exchange rate prediction is one of the challenging applications of modern time series forecasting and very important for the success of many businesses and financial institutions. The rates are inherently noisy, non-stationary and deterministically chaotic. One general assumption is made in such cases is that the historical data incorporate all those behavior. As a result, the historical data is the major input to the prediction process. Forecasting of exchange rate poses many challenges. Exchange rates are influenced by many economic factors. As like economic time series exchange rate has trend cycle and irregularity. Classical time series analysis does not perform well on finance-related time series. Hence, the idea of applying Neural Networks (NN) to forecast exchange rate has been considered as an alternative solution. NN tries to emulate human learning capabilities, creating models that represent the neurons in the human brain. In addition, recent research has been directed to Support Vector Machine (SVM) which has emerged as a new and powerful technique for learning from data and in particular for solving classification and regression problems with better performance. The main advantage of SVM is its ability to minimize structural risk as opposed to empirical risk minimization as employed by the NN system.

In this forecasting part I used an MLP-NN and a SVM-based regression (SVR) model to predict the next step-ahead exchange rate of GBP/EUR. Daily data (exchangeGBP.xls) have been collected from January 2010 until December 2011 (500 data). The first 400 of them are used as training data, while the remaining ones as testing set. Only used the 2nd column from the .xls file, which corresponds to the exchange rates.


### Task 3. MLP & SVR
* Discuss the input selection problem and propose various input configurations
*	Design a number of MLPs, using various structures (layers/nodes) / input parameters and show in a table their performances comparison based on provided stat. indices	
* Design an SVR and use various structures/parameters (incl. linear/nonlinear kernels)
*	Provide the best results both graphically (prediction output vs. desired output) and via performance indices	
