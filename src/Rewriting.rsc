module Rewriting

import Prelude;
import ParseTree;
import lang::java::\syntax::Java15;
import refactor::RemoveAutowired;
import util::DirectoryTraverser;
import util::Parse;

public void main(str arg) {
  loc project = |file:///| + arg;
  checkIfLocationExistsAndIsDirectory(project);
  
  rewrite(project);
}

void rewrite(loc project) {
  list[loc] sourceFiles = getAllFilesFor(project);
  list[Tree] parseTrees = parse(sourceFiles);
  
  for (Tree parseTree <- parseTrees) {
    Tree tree = removeAutowired(parseTree);
    writeFile(parseTree@\loc, tree);
  }
}
