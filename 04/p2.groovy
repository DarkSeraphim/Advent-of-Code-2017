InputStream.metaClass.untilEnd = { closure ->
    delegate.eachLine("UTF-8") {
        if ("end-of-input".equals(it)) {
            return;
        }
        closure(it)
    }
}
counter = 0;
System.in.untilEnd {
  tokens = it.tokenize(' ').collect{it.collect{it}.sort().join('')}
  if (tokens.toSet().size() == tokens.size()) counter++
}
println(counter)
