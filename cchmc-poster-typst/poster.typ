#let transpose(arr, height) = {
  let width = calc.ceil(arr.len() / height)
  let missing = width * height - arr.len()
  // add dummy elements so that the array is "rectangular"
  arr += (none,) * missing
  // transpose the array
  array.zip(..arr.chunks(width)).join().filter(x => x != none)
}


#let preprocesHeadings(doc) = {
  let headings = ()
  let index = -1
  for i in doc.children {
    if i.func() == heading and i.depth == 1 {
      index = index + 1
      headings.push(())
    }
    if index >= 0 {
      headings.at(index).push(i)
    }
  }
  return headings
}


#let funbox(title, content) = {
  table(
    stroke: none,
    inset: 0.5em,
    columns: 1fr,
    fill: (x, y) => if x == 0 and y == 0 { rgb("c0da83") },

    align(left, title),
    content,
  )
}

#let headingsToBoxes(headings) = {
  let boxed_headings = ()
  for i in headings {
    let head = i.at(0)
    let body = i.slice(1, i.len())
    boxed_headings.push(funbox(head, body.join()))
  }
  return boxed_headings
}

#let get_affiliation(authors) = {
  let affiliations = authors.values().map(x => x.at("affiliation")).flatten().dedup()
  affiliations = affiliations.zip(range(affiliations.len()))

  let get_numbers_from_affils(affils) = {
    return affils.map(x => str(affiliations.to-dict().at(x) + 1)).dedup()
  }
  let authors = authors
    .keys()
    .zip(authors.values())
    .map(X => {
      X.at(0)
      super(get_numbers_from_affils(X.at(1).at("affiliation")).join(","))
    })


  affiliations = affiliations.map(X => [#super([#{ X.at(1) + 1 }])#X.at(0)])
  return (authors, affiliations)
}

#let conf(
  title: none,
  base_text_size: 36pt,
  height: 24in,
  width: 36in,
  ncolumns: 4,
  nrows: 1,
  authors: (:),
  colspans: 1,
  rowspans: 1,
  x: (),
  y: (),
  doc,
) = {
  if type(nrows) == int {
    nrows = (1fr,) * nrows
  }
  if type(ncolumns) == int {
    ncolumns = (1fr,) * ncolumns
  }
  let img = image("Picture1.png", width: 100%)
  let cchmclogo = image("cchmc-logo.svg", height: 100%)
  set text(font: "Arial", size: base_text_size)
  let headings = preprocesHeadings(doc)
  let get_af = get_affiliation(authors)
  set page(
    height: height,
    width: width,
    header-ascent: 1em,
    header: pad(
      right: 1em,
      left: 0em,
      bottom: 0em,
      grid(
        column-gutter: 1em,
        columns: (4fr, 1fr),
        block(
          fill: rgb("a1cc3a"),
          width: 100%,
          height: 100%,
          align(
            horizon,
            pad(
              stack(
                spacing: 0.5em,
                text(size: 1.5em, weight: "bold", title),
                text(get_af.at(0).join(", "), weight: "bold"),
                text(get_af.at(1).join(", ")),
              ),
              left: 1em,
              bottom: 0em,
            ),
          ),
        ),
        cchmclogo,
      ),
    ),
    margin: (top: 6em, left: 0pt, right: 0pt, bottom: 1.5em),
    footer: align(bottom)[#img],
  )
  let heading_boxes = headingsToBoxes(headings)
  if type(rowspans) == int {
    rowspans = (rowspans,) * heading_boxes.len()
  }
  if type(colspans) == int {
    colspans = (colspans,) * heading_boxes.len()
  }

  if x == () {
    let current_index = 0
    for s in colspans {
      x.push(current_index)
      current_index = current_index + s
    }
    x = x.map(x => calc.floor(x / nrows.len()))
  }
  if y == () {
    let current_index = 0
    for s in colspans {
      y.push(current_index)
      current_index = current_index + s
    }
    y = y.map(y => calc.rem(y, nrows.len()))
  }
  //repr(array.zip(x, y))
  heading_boxes = heading_boxes
    .zip(colspans, rowspans, x, y)
    .map(x => grid.cell(y: x.at(4), x: x.at(3), stroke: gray, rowspan: x.at(2), colspan: x.at(1), x.at(0)))

  //heading_boxes = transpose(heading_boxes, ncolumns.len())
  pad(
    left: 1em,
    right: 1em,
    top: 0em,
    bottom: 0em,
    grid(
      column-gutter: 1em,
      row-gutter: 1em,
      columns: ncolumns,
      rows: nrows,
      ..heading_boxes
    ),
  )
}



#let (x, y) = get_affiliation((
  "David Lewis": (affiliation: ("University of cincinatti",)),
  "BigMan": (affiliation: ("University of cincinatti", "University of Prague")),
))

#x.join(", ")
#y.join(", ")
