complete -c zdict -s t -l query-timeout -d 'Set timeout for every query. default is 5 seconds.'
complete -c zdict -s j -l jobs -d 'Allow N jobs at once. Do not pass any argument to use the number of CPUs in the system.'
complete -c zdict -l dict -d 'Must be seperated by comma and no spaces after each comma. Choose the dictionary you want. (default: yahoo) Use 'all' for qureying all dictionaries. If 'all' or more than 1 dictionaries been chosen, --show- provider will be set to True in order to provide more understandable output.' -r -f -a 'urban yahoo jisho spanish moe all'
complete -c zdict -l dump -d 'Dump the querying history, can be filtered with regex'
complete -c zdict -s d -l disable-db-cache -d 'Temporarily not using the result from db cache. (still save the result into db)'
complete -c zdict -l show-provider -d 'Show the dictionary provider of the queried word'
complete -c zdict -l show-url -d 'Show the url of the queried word'
complete -c zdict -l list-dicts -d 'Show currently supported dictionaries.'
complete -c zdict -s V -l verbose -d 'Show more information for the queried word. (If the chosen dictionary have implemented verbose related functions)'
complete -c zdict -s c -l force-color -d 'Force color printing (zdict automatically disable color printing when output is not a tty, use this option to force color printing)'
complete -c zdict -s D -l debug -d 'Print raw html prettified by BeautifulSoup for debugging.'
complete -c zdict -s h -l help -d "show program's version number and exit"
complete -c zdict -s v -l version -d "show program's version number and exit"
