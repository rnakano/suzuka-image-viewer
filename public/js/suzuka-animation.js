Suzuka.Animation = function(){
  var leftSwipeAnimation = function(obj1, obj2){
    var x = 0 - $(window).width() - 60;
    swipeAnimation(obj1, x, obj2, 0);
  };

  var rightSwipeAnimation = function(obj1, obj2){
    var x = 0 + $(window).width() + 60;
    swipeAnimation(obj1, x, obj2, 0);
  };

  var swipeAnimation = function(obj1, x1, obj2, x2){
    obj1.css({
      "-webkit-transform": "translate3d(" + x1 + "px, 0px, 0)",
      "-webkit-transition": "-webkit-transform 200ms linear"
    });

    obj2.css({
      "-webkit-transform": "translate3d(" + x2 + "px, 0px, 0)",
      "-webkit-transition": "-webkit-transform 200ms linear"
    });
  };

  var moveX = function(obj, x){
    return obj.css({
      "-webkit-transform": "translate3d(" + x + "px, 0px, 0)"
    });
  };

  return {
    leftSwipe : leftSwipeAnimation,
    rightSwipe : rightSwipeAnimation,
    moveX : moveX
  };
}();