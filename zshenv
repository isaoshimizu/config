function strip_diff_leading_symbols(){
  color_code_regex="(\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K])"
  # simplify the unified patch diff header
  gsed -r "s/^($color_code_regex)diff --git .*$//g" | \
  gsed -r "s/^($color_code_regex)index .*$/\n\1$(rule)/g" | \
  gsed -r "s/^($color_code_regex)\+\+\+(.*)$/\1+++\5\n\1$(rule)\x1B\[m/g" |\

  # actually strips the leading symbols
  gsed -r "s/^($color_code_regex)[\+\-]/\1 /g"
}

## Print a horizontal rule
rule () {
  printf "%$(tput cols)s\n"|tr " " "─"
}
