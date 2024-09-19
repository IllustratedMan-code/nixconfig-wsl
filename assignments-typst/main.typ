#let author(name, affiliation:none, email: none, ) = (name: name, affiliation: affiliation, email: email)
#let conf(
  title: none,
  authors: (author([David Lewis], email: "lewis3d7@mail.uc.edu"), ),
  titlepage: true,
  doc,
) = {
  let style-number(number) = text(gray)[#number]
  let date = datetime.today().display("[month repr:long] [day], [year]")
  show raw.where(block: true): it => {
        let lang = [#upper(it.lang.first())#it.lang.slice(1)] 
        set align(center)
        grid(
          columns: 1,
          inset: 3pt,
          align: (right),
        stack(
        box(stroke: black, inset: 3pt, outset: 0pt,
          radius: (
            top-left: 5pt,
            top-right: 5pt,
            bottom-right: 0pt,
            bottom-left: 0pt
          ),
          [
            #set text(8pt)
            #lang
          ]),
        box(
          outset: 0pt,
          stroke: black,
          radius: (
            top-left: 5pt,
            top-right: 0pt,
            bottom-right: 5pt,
            bottom-left: 5pt
          ),

          inset: (x: 5pt, y: 5pt),
          grid(
            columns: 2,
            align: (right, left),
            gutter: 0.5em,
            ..it.lines
              .map(line => (style-number(line.number), line))
              .flatten()
      ))))
  }
  set page(
    paper: "us-letter",
    header: context{if counter(page).get().first() > int(titlepage) and title != none [
      #title
      #h(1fr)
      #date
    
      #line(length: 100%)
    ]},
    footer: [
      #line(length: 100%)
      
      #authors.map(author => [#author.name]).join(",")
      #h(1fr)
      #counter(page).display()
    ]
  )
  // quotes
  set quote(block: true, quotes: true)
  show quote: quote => {set align(center); box(inset: 5pt, fill: rgb("#ffebcd"), radius: 5pt, quote)}


  let r = rect(height: 2pt, fill: black, width: 100%)
  //show heading: it => text(weight: 2, it.body)
  show heading.where(level: 1): it => block(align(center, grid(
    columns: (1fr, auto, 1fr),
    align: horizon,
    gutter: 5pt, 
    r,
    [#it],
    r
  )), breakable: false,
  )
  show heading.where(level: 2): it => block(align(left, grid(
    columns: (auto, 1fr),
    align: horizon,
    gutter: 5pt, 
    [#it],
    rect(height: 1pt, fill: black, width:100%)
  )), breakable: false,
  )
  show heading.where(level: 3): it => underline(it)
  {
    set align(center)
    if titlepage and title != none{
      [ #text(17pt, weight: "bold",  title) \ 
        #text(12pt, weight: "bold", date)
      ]

    

    let count = authors.len()
    let ncols = calc.min(count, 3)
    grid(
      columns: (1fr,) * ncols,
      row-gutter: 2pt,
      ..authors.map(author => [
        #author.name \
        #if author.affiliation != none {
          [#author.affiliation \ ]
        } 
        #if author.email != none{
          link("mailto:" + author.email)
        }
      ]),
    ) }
  }
  doc
}
