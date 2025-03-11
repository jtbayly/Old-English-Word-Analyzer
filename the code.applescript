on run {input}
	set angloSaxonWords to {"a", "A-1", "A-frame", "A-line", "a.k.a.", "a.s.a.p.", "aback", "abaft", "abeam", "abear ", "abed", "abide", "the", "moreWordsHere", "zax"}
	
	-- Convert angloSaxonWords to a set for faster lookups
	set angloSet to {}
	repeat with theWord in angloSaxonWords
		set angloSet to angloSet & {theWord as text}
	end repeat
	
	try
		set inputText to item 1 of input as text
		
		-- Clean the input text in one go
		set cleanText to do shell script "echo " & quoted form of inputText & " | tr '[:upper:]' '[:lower:]' | sed -e 's/[^a-z0-9 ]//g'"
		set wordList to words of cleanText
		
		set totalCount to 0
		set angloCount to 0
		
		repeat with aWord in wordList
			set totalCount to totalCount + 1
			if angloSet contains aWord then
				set angloCount to angloCount + 1
			end if
		end repeat
		
		if totalCount = 0 then error "No valid words found"
		
		set otherCount to totalCount - angloCount
		set percentage to (angloCount / totalCount) * 100
		
		display dialog "Anglo-Saxon words: " & angloCount & return & ¬
			"Other words: " & otherCount & return & ¬
			"Percentage: " & roundTo(percentage, 1) & "%" with title "Word Origins" buttons {"OK"}
		
	on error errMsg
		display alert "Error" message errMsg
	end try
end run

on roundTo(num, decimals)
	set factor to 10 ^ decimals
	return (round (num * factor)) / factor
end roundTo
