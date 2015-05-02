# parse .txt files for word counts. Ignores punctation marks and numbers.
# Remember to write output of this to a new file, else it will just display on stdout.
BEGIN {
  # Get rid all punctuation except '.?! for sentences and contractions.
  # This field separator was incredibly difficult to get working
  FS = "`|~|\\.- |.\\..\\..|' |'|,|1|2|3|4|5|6|7|8|9|0|-|_|@|#|%|^|&|$|\\(|\\)|;|:|\"|\\.\\.\\.|\\[|\\]|' |*|\\/| \\.|\\n|\\0|\\t|\\a|\\b|\\f|\\r|\\v| "
  sentence = 0;
  word_count = 0;
  word_lengths = 0;
  longest_word = 0;
  shortest_word = 10;
  len = 0; #length of each word, to reduce length() calls
}
{
	for( i = 1; i <= NF; i++ )
	{
    len = length($i);
    if( len > 0)
    {
      if( index( $i,"." ) > 1 || index( $i,"?") > 1  || index( $i,"!") > 1) #sentence
      {
        sentence++;
        $i = substr($i,1,len-1);
        len = length($i);
      }
      if( index( $i,"." ) == 1 || index( $i,"?") == 1  || index( $i,"!") == 1) #period at beginning
        continue;
      if( len > 0 )
      {
        if( $i == "s")
          continue;
        if( len > longest_word)
          longest_word = len;
        if( len < shortest_word)
          shortest_word = len;
        word_count++;
        word_lengths += len;
        words[tolower($i)]++;
      }
    }
	}
}
END {
  printf "REPORT:\nWord Count: %d\t\tAverage Word Length: %f\t\tNumber of Sentences: %d\nLength of Shortest Word: %d\t Longest Word: %d\n", word_count, word_lengths/word_count, sentence, shortest_word, longest_word;
  # Sorting words with frequencies by making a temp array with the freq concatenated to the word for indices, then sorting by indices
  # right justify the integers into space-padded strings and cat the index
  # to create the new index
  for (i in words) 
    tmpidx[sprintf("%4s", words[i]),i] = i 
    # tempidx is a 2D matrix. [freq,word]
  num = asorti(tmpidx)
  j = 0
  # SUBSEP - awk variable for separator in matrix indices ex. array[5,2] SUBSEP is ','
  for (i=1; i<=num; i++) {
      split(tmpidx[i], tmp, SUBSEP)
      indices[++j] = tmp[2]  # tmp[2] is the name
  }
  print "\nTop 15 most frequent words:"
  for (i=0; i<15; i++)
  {
    tmpword = sprintf ("%s: %d", indices[num-i], words[indices[num-i]])
    printf "%-25s\t", tmpword
    #printf ("| %s: (%d) %d| \n", indices[num-i], length(indices[num-i]), words[indices[num-i]])
    if (i%5 == 4)
      print ""
  }
  print ""
  print "Top 15 least frequent words:"
  for (i=1; i<=15; i++) 
  {
    tmpword = sprintf ("%s: %d", indices[i], words[indices[i]])
    printf "%-25s\t", tmpword
    #printf ("|%s: %d| \n", indices[i], words[indices[i]])
    if (i%5 == 0)
      print ""
  }
}

