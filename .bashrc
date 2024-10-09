alias sudo='sudo'
alias vim='nvim'
alias nrs='nixos-rebuild switch --flake ~/nixconfig#nixos'

pdfcombine ()
{
   gs -q -dNOPAUSE -sDEVICE=pdfwrite -sOUTPUTFILE=${1%.*}.pdf -dBATCH ${@:2}
}

# pdfinterleave odd.pdf even.pdf output.pdf
pdfinterleave ()
{
    pdftk A=${1%.*}.pdf B=${2%.*}.pdf shuffle A B output ${3%.*}.pdf
}

pdfinterleavebend ()
{
    pdftk A=${1%.*}.pdf B=${2%.*}.pdf shuffle A Bend-1 output ${3%.*}.pdf
}