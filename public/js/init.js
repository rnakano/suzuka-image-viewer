var currentBoxIndex = 0;

var loadInitialImages = function(){
  loadImage(0, CENTER);
  loadImage(1, LEFT);
};

var createEmptyImageBox = function(i, url){
  return $("<div>").addClass("image-box").append($("<img>").attr("src", url).addClass("image")).attr("id", "image-box-" + i);
};

var LEFT = 1, RIGHT = -1, CENTER = 0;

var loadImage = function(i, direction){
  var width = $(window).width();
  var imageBox = createEmptyImageBox(i, imageFileList[i]);
  if(direction == LEFT) {
    Suzuka.Animation.moveX(imageBox, width + 50);
  } else if(direction == RIGHT) {
    Suzuka.Animation.moveX(imageBox, -1 * width - 50);
  } else if(direction == CENTER) {
    Suzuka.Animation.moveX(imageBox, 0);
  }
  $("#swipe-box").append(imageBox);
  console.log("load: " + i);
};

var unloadImage = function(i){
  searchImageBox(i).remove();
  console.log("unload: " + i);
};

var searchImageBox = function(i){
  return $("#image-box-" + i);  
};

var setupImageBox = function(){
    Suzuka.Swipe.detector( $("#swipe-box"), {
      onLeftSwipe : function(){
        if(currentBoxIndex < imageFileList.length - 1) {
          Suzuka.Animation.leftSwipe(searchImageBox(currentBoxIndex),
                                     searchImageBox(currentBoxIndex+1));
          if(currentBoxIndex > 0) unloadImage(currentBoxIndex-1);
          loadImage(currentBoxIndex+2, LEFT);
          currentBoxIndex += 1;
        }
      },
      onRightSwipe : function(){
        if(currentBoxIndex > 0) {
          Suzuka.Animation.rightSwipe(searchImageBox(currentBoxIndex),
                                      searchImageBox(currentBoxIndex-1));
          if(currentBoxIndex < imageFileList.length - 1)
            unloadImage(currentBoxIndex+1);
          loadImage(currentBoxIndex - 2, RIGHT);
          currentBoxIndex -= 1;
        }
      }
    });
  };

$(function(){
  loadInitialImages();
  setupImageBox();
});