const scale = 1000000000; //Allows us to avoid floating point rounding errors

function point(centreX, centreY, label) {

  myPoint = drawing.append("circle")
  .style("stroke", "none") // Do not draw the line
  .style("fill", "none")   // Do not fill
  .attr("class", "point")  //Assign the "point" class so we can later grab/filter it
  .attr("r", 0)            //radius = 0
  .attr("cx", centreX)
  .attr("cy", centreY)
  .attr("label", label)    //This is optional.
  ;                        //It follows geometry textbooks

  return myPoint
}

function lineFromTwoPoints( A, B, strokeWidth, colour ) {
  //Draws a line from two points, and returns the line
  if (typeof colour == 'undefined'){
    colour = "rgb(0,0,50)";
  }
  if (typeof strokeWidth == 'undefined'){
    strokeWidth = 1; //This is the default anyway
  }

  var myLine = drawing.append("svg:line")
  //x to the left
  .attr("x1", A.attr("cx"))
  .attr("y1", A.attr("cy"))
  .attr("x2", B.attr("cx"))
  .attr("y2", B.attr("cy"))
  .attr("stroke-width", strokeWidth)
  .style("stroke", colour);

  return myLine;
}

function circle(centrePoint, radius, colour){
  // Simply draws a circle. Returns an object such as "circle1 = new circle(A, 50)"
  if (typeof colour == 'undefined'){
    colour = "black";
  }

  myCircle = drawing.append("circle")
  .style("stroke", colour)
  .style("fill", "none")
  .attr("r", radius)
  .attr("cx", centrePoint.attr("cx"))
  .attr("cy", centrePoint.attr("cy"))
  .attr("label", "Circle".concat(centrePoint.attr("label"))) //This returns "CircleA" if point A has a label of "A"
  ;

  return myCircle;
}

function circleFilled (centrePoint, radius, colour){
  // Simply draws a circle. Returns an object such as "circle1 = new circleFilled(A, 50)"
  if (typeof colour == 'undefined'){
    colour = "black";
  }

  myFilledCircle = drawing.append("circle")
  .style("stroke", "none")
  .style("fill", colour)
  .attr("r", radius)
  .attr("cx", centrePoint.attr("cx"))
  .attr("cy", centrePoint.attr("cy"))
  .attr("label", "Circle".concat(centrePoint.attr("label"))) //This returns "CircleA" if point A has a label of "A"
  ;

  return myFilledCircle;
}

function distanceBetweenTwoPoints (pointA, pointB) {
  // Also known as "the distance formula" (a^2 + b^2 = c^2)

  distanceXScaled = ((pointB.attr("cx") *scale) - (pointA.attr("cx") *scale));
  distanceYScaled = ((pointB.attr("cy") *scale) - (pointA.attr("cy") *scale));

  lineLengthScaled = Math.sqrt(Math.pow(distanceXScaled, 2) + Math.pow(distanceYScaled, 2));

  lineLength = Math.round(lineLengthScaled) / scale;

  return lineLength;
}
