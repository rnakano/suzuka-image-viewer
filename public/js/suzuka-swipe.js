Suzuka.Swipe = function(){
  var LEFT_SWIPE = 1, RIGHT_SWIPE = -1;
  var ringBuffer = function(){
    var buffer = [];
    
    return {
      push : function(n){
        buffer.push(n);
      },

      bigChange : function(){
        var max = Math.max.apply(null, buffer);
        var min = Math.min.apply(null, buffer);
        if(max - min > 50) {
          if(buffer[0] < buffer[buffer.length-1]) {
            return RIGHT_SWIPE;
          } else {
            return LEFT_SWIPE;
          }
        } else {
          return 0;
        }
      }
    };
  };

  var installSwipeEvent = function(box, callbacks){
    var startX, buffer;

    box.bind("touchstart", function(event){
      startX = event.originalEvent.pageX;
      buffer = ringBuffer();
    });

    box.bind("touchend", function(event){
      var change = buffer.bigChange();
      if(change != 0) {
        if(change == LEFT_SWIPE) {
          callbacks.onLeftSwipe();
        } else if (change == RIGHT_SWIPE){
          callbacks.onRightSwipe();
        }
      }
    });      
    
    box.bind("touchmove", function(event){
      event.preventDefault();
      var pageX = event.originalEvent.pageX;
      var diffX = (pageX - startX);
      buffer.push(diffX);
    });
  };

  var RIGHT_KEY = 39;
  var LEFT_KEY = 37;
  
  var installKeyPager = function(box, callbacks){
    box.bind("click", function(event){
      callbacks.onLeftSwipe();
    });
  };

  var detector = function(swipeTarget, callbacks){
    if('ontouchstart' in window) {
      installSwipeEvent(swipeTarget, callbacks);
    } else {
      // fallback
      installKeyPager(swipeTarget, callbacks);
    }
  };

  return {
    detector : detector
  };
}();