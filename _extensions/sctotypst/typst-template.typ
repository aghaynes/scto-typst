// SCTO, typst template
// Alan Haynes
// Department of Clinical Research, University of Bern
// Some source https://github.com/LaPreprint/typst/blob/main/lapreprint.typ
// Based heavily on the DCRs template

// Last changes:
// - Added project number
// - Multiple authors
// - TOC

#let scto_typst_template(
  title: none,
  subtitle: none,
  projectno: none,
  toc: false,
  author: (),
  affiliations: (),
  path_logo: "/_extensions/scto/sctotypst/",
  // logo_size: filename (fore example, "dcrlogo.jpg")
  logo: "SCTO_Platforms.png",
  // logo_size: percentage (for example, 80%) or auto
  logo_size: 100%,
  date: datetime.today(),
  paper-size: "a4",
  font-face: "Arial",
  heading-numbering: "1.1.1",
  project_type: "Project",
  body,
) = {



 set table(
  inset: 6pt,
   stroke: none
 )



  // Spacer for footer
  let spacer = text(fill: gray)[#h(8pt) | #h(8pt)]

  // Set document metadata
  set document(title: title)

  // Set the body font
  set text(font: font-face)

  // Configure title page
  set page(
    paper-size,
    margin: (left: 3cm, right: 2cm, top: 5cm, bottom: 4cm),
    header: block(
      width: 100%,
      inset: (top: 1pt, right: 2pt),
      if (logo != none) {
        place(
          top+right,
          dy: -2cm,
          float: false,
        box(
          width: 27%,
          if (paper-size == "a4") { image(path_logo+logo, width: 100%) } else if (paper-size == "a3") { image(path_logo+logo, width: 90%) } else if (paper-size == "a2") { image(path_logo+logo, width: 70%) } else if (paper-size == "a1") { image(path_logo+logo, width: 60%) } else if (paper-size == "a0") { image(path_logo+logo, width: 50%) }
        )
      )
      }
    ),
    footer: block(
      width: 100%,
      inset: (top: 1pt, right: 2pt),
      if (logo2 != none) {
        place(
          top+left,
          dx: 0cm,
          dy: -0.6cm,
          float: false,
        box(
          width: 40%,
          height: 100%,
          if (paper-size == "a4") { image(path_logo+logo2, width: 40%) } else if (paper-size == "a3") { image(path_logo+logo2, width: 30%) } else if (paper-size == "a2") { image(path_logo+logo2, width: 20%) } else if (paper-size == "a1") { image(path_logo+logo2, width: 15%) } else if (paper-size == "a0") { image(path_logo+logo2, width: 10%) }
        )
      )
      }
    ),
  )

  v(0.1fr)

  // Set title
  set align(left)
  text(size: 17pt, title, weight: "bold")
  v(0.01fr)
  // Set subtitle
  if subtitle != none {
  text(size: 14pt, subtitle, weight: "semibold")
  }
  v(0.01fr)
  // Set project number
  if projectno != none {
  text(size: 14pt, project_type + " number: " + projectno)
  }
  v(0.01fr)

  // set text(size: 10pt)
  text("Date: ")
  date.display("[month repr:long] [day], [year]")
  v(0.05fr)
  // First horizontal line
  line(length: 100%)

  if author.len()>1 {
  text(size: 14pt, "Authors: ")
  v(0.01fr)
  }
  if author.len()==1 {
  text(size: 14pt, "Author: ")
  v(0.01fr)
  }

  if author != none and author != [] {
    let count = author.len()
    let ncols = calc.min(count, 3)
    grid(
      columns: (1fr,) * ncols,
      row-gutter: 1.5em,
      ..author.map(author =>
          align(left)[
            #author.name \
            #author.affiliation \
            #author.email
          ]
      )
    )
  }

  // Second horizontal line
  line(length: 100%)

  v(0.2fr)

  // Set counter for pages
  counter(page).update(0)


  // Table of content
  if toc != false {

    // Space between section heading
  show heading: it => {
    it.body
    v(0.7em)
  }

  pagebreak()
  counter(page).update(0)
   outline(indent: auto)
  }

  // Configure main document pages



  set page(
    paper-size,
    margin: (left: 3cm, right: 2cm, top: 5cm, bottom: 4cm),
    numbering: "1",
    number-align: right,
    header: block(
      width: 100%,
      inset: (top: 1pt, right: 2pt),
      if (logo != none) {
        place(
          top+right,
          dy: -2cm,
          float: false,
        box(
          width: 27%,
          if (paper-size == "a4") { image(path_logo+logo, width: 100%) } else if (paper-size == "a3") { image(path_logo+logo, width: 90%) } else if (paper-size == "a2") { image(path_logo+logo, width: 70%) } else if (paper-size == "a1") { image(path_logo+logo, width: 60%) } else if (paper-size == "a0") { image(path_logo+logo, width: 50%) }
        ),
      )
      }
    ),
    footer: block(
      width: 100%,
      inset: (top: 1pt, right: 2pt),
      [
       #place(
          top+left,
          dx: 0cm,
          dy: -0.6cm,
          float: false,
        box(
          width: 40%,
          height: 100%,
          if (paper-size == "a4") { image(path_logo+logo2, width: 40%) } else if (paper-size == "a3") { image(path_logo+logo2, width: 30%) } else if (paper-size == "a2") { image(path_logo+logo2, width: 20%) } else if (paper-size == "a1") { image(path_logo+logo2, width: 15%) } else if (paper-size == "a0") { image(path_logo+logo2, width: 10%) }
        )
      ),
        #grid(columns: (100%, 20%),
          align(right)[
            #text(
              size: 9pt, fill: gray.darken(50%)
            )[
            #counter(page).display() of #locate((loc) => {counter(page).final(loc).first()})
            ]
          ],


        )
      ]
    )
  )

  pagebreak()

  // Configure headings.
  set heading(numbering: heading-numbering)

  // Space between section headings
  show heading: set block(above: 1cm, below: 0.5cm)

  set align(left)
  text(size: 9pt, body)

  set par(justify: true, leading: 2em)

}
