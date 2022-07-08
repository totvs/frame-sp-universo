function(codeType, codeContent) {
  if (codeType === "advplToJs") {
    console.log(codeContent)
  } else {
    this.eventTarget.send(codeType, codeContent);
  }
}
