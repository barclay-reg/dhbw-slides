/***********************
 *    INITIALIZATION   *
 ***********************/


var myTemplateConfig = {
 branch: {
   color: "#000000",
   lineWidth: 6,
   spacingX: 50,
   mergeStyle: "bezier",
   labelRotation: 0,
   labelFont: "normal 14pt Calibri",
   showLabel: true
 },
 commit: {
   spacingY: -60,
   dot: {
     size: 16,
     strokeColor: "#000000",
     strokeWidth: 7
   },
   message: {
     color: "black",
     displayAuthor: false
   }
 },
 arrow: {
   size: 16,
   offset: 2.5
 }
}; 

var myTemplate = new GitGraph.Template(myTemplateConfig);

var config = {
  template: myTemplate, // could be: "blackarrow" or "metro" or `myTemplate` (custom Template object)
  reverseArrow: false, // to make arrows point to ancestors, if displayed
  orientation: "vertical",
  // mode: "compact" // special compact mode: hide messages & compact graph
};
var gitGraph = new GitGraph(config);

// Create branch named "master"
var master = gitGraph.branch("origin/master");

// Commit on HEAD Branch which is "master"
gitGraph.commit("Initial commit");

// Add few commits on master
gitGraph.commit("My second commit").commit("Add awesome feature");

// Create a new "dev" branch from "master" with some custom configuration
var dev = master.branch({
  name: "master",
  color: "#F00",
  // lineDash: [5],
  commitDefaultOptions: {
    color: "#F00"
  }
});
dev.commit("Commit on local master");

master.commit("Commit from teammate");

// 1.
//dev.merge(master, "Merge dev into master");

