function Div(el)
  if el.classes and el.classes:find("cell-output") then
    return{
      pandoc.RawBlock(
        "html", "<details class='details'<summary>Output</summary>"
      ),
      el,
      pandoc.RawBlock("html", "</details>")
    }
  end
end