listFilterMethods = function(){

	filterMethods = c('auc', 'cmim', 'disr',
	 'find_correlation', 'importance', 'information_gain', 
	 'jmi', 'jmim', 'kruskal_test', 'mim', 'mrmr', 'njmim',
	  'performance', 'permutation', 'relief', 'variance')

	print(filterMethods)
	return(filterMethods)
}