while (<>) {
    s/([\x80-\xff])/sprintf "\\x{%02x}",ord($1)/eg;
    print;
}