[ -z "$GHC" ] && GHC="ghc"
$GHC -O2 --make Litmus.lhs -o litmus
$GHC -O2 --make Translate -o litmus-translate
