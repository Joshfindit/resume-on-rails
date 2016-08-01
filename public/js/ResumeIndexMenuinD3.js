+ function(d3) {

  var swatches = function(el) {
    var w = screen.width * .92;
    var h = screen.height * .618;

    var circleWidth = 10;

    var palette = {
      "lightgray": "#819090",
      "gray": "#708284",
      "mediumgray": "#536870",
      "darkgray": "#475B62",
      "darkblue": "#0A2933",
      "darkerblue": "#042029",
      "paleryellow": "#FCF4DC",
      "paleyellow": "#EAE3CB",
      "yellow": "#A57706",
      "orange": "#BD3613",
      "red": "#D11C24",
      "pink": "#C61C6F",
      "purple": "#595AB7",
      "blue": "#2176C7",
      "green": "#259286",
      "white": "#fefefe",
      "yellowgreen": "#738A05"
    }

    var myChart = d3.select("svg")
      .attr('width', w)
      .attr('height', h);

    var force = d3.layout.force()
      .nodes(nodes)
      .links([])
      .gravity(0.1)
      .charge(-750)
      .size([w, h]);

    
    var links = [];

    for (var i = 0; i < nodes.length; i++) {
      if (nodes[i].target !== undefined) {
        for (var x = 0; x < nodes[i].target.length; x++) {
          links.push({
            source: nodes[i],
            target: nodes[nodes[i].target[x]]
          })
        }
      }
    }

    var link = myChart.selectAll('line')
      .data(links).enter().append('line')
      .attr('stroke', palette.mediumgray);

    var node = myChart.selectAll('circle')
      .data(nodes).enter()
      .append('g')
      .call(force.drag);

  
    node.append('circle')
      .attr('fx', function(d) {
        if (i > 0) {
          return false;
        } else {
          return 500;
        }
      })
      .attr('fy', function(d) {
        if (i > 0) {
          return false;
        } else {
          return 150;
        }
      })
      .attr('cx', function(d) {
        if (i > 0) {
          return d.x;
        } else {
          return w/10;
        }
        
      })
      .attr('cy', function(d) {
        if (i > 0) {
          return d.y;
        } else {
          return h/10;
        }
      })
      .attr('r', circleWidth)
      .attr('stroke', function(d, i) {
        if (i > 0) {
          return palette.pink;
        } else {
          return "transparent";
        }
      })
      .attr('stroke-width', 2)
      .attr('fill', function(d, i) {
        if (i > 0) {
          return palette.white;
        } else {
          return "transparent";
        }
      });

    label = node.append('text')
      .text(function(d) {
        return d.name
      })
      .attr('class', 'nodelabel')
      .attr('font-family', 'Roboto Slab')
      .attr('fill', function(d, i) {
        if (i > 0) {
          return palette.mediumgray;
        } else {
          return palette.darkgray;
        }
      })
      .attr('x', function(d, i) {
        if (i > 0) {
          return circleWidth + 20;
        } else {
          return circleWidth - 15;
        }
      })
      .attr('y', function(d, i) {
        if (i > 0) {
          return circleWidth;
        } else {
          return 8;
        }
      })
      .attr('text-anchor', function(d, i) {
        if (i > 0) {
          return 'beginning';
        } else {
          return 'end';
        }
      })
      .attr('font-size', function(d, i) {
        if (i > 0) {
          return '2rem';
        } else {
          return '3.4rem';
        }
      })
      .on("click",function(d){
        if (d.url) {
          window.location = d.url
        }
      });


    force.on('tick', function(e) {

      node.attr("transform", function(d, i) { 
        d.x = Math.max(circleWidth + 10, Math.min(w - circleWidth - 10, d.x));
        d.y = Math.max(circleWidth + 10, Math.min(h - circleWidth - 10 , d.y));
        return 'translate(' + d.x + ', ' + d.y + ')';
      })

      link.attr("x1", function(d) { return d.source.x; })
          .attr("y1", function(d) { return d.source.y; })
          .attr("x2", function(d) { return d.target.x; })
          .attr("y2", function(d) { return d.target.y; });
    })

  
    resize();
    d3.select(window).on("resize", resize);

    function resize() {
      w = window.innerWidth * 0.92, h = window.innerHeight / 2;
      myChart.attr("width", w).attr("height", h);
      force.charge(-(w/2));
      force
        .size([w, h])
        .resume();
      label.attr("font-size", Math.min(Math.max(window.innerHeight / 17, 15), 30));
      force.start();
    }

    force.start();

  }('#demo');

}(window.d3);