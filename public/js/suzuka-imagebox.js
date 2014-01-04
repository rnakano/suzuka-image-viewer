Suzuka.ImageBox = function(div, imageFileList){
  var LEFT = 1, RIGHT = -1, CENTER = 0;
  var currentBoxIndex = 0;
  
  var createEmptyImageBox = function(i, url){
    return $("<div>").addClass("image-box").append($("<img>").attr("src", url).addClass("image")).attr("id", "image-box-" + i);
  };

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
    div.append(imageBox);
  };

  var unloadImage = function(i){
    searchImageBox(i).remove();
  };

  var unloadAllImage = function(){
    div.find(".image-box").remove();
  };

  var searchImageBox = function(i){
    return $("#image-box-" + i);  
  };

  return {
    setCurrentIndex : function(i){
      if(i < 0 || imageFileList.length <= i) return;
      unloadAllImage();
      if(i - 1 >= 0) loadImage(i - 1, RIGHT);
      loadImage(i, CENTER);
      if(i + 1 < imageFileList.length) loadImage(i + 1, LEFT);
      currentBoxIndex = i;
    },
    goRightImage : function(){
      Suzuka.Animation.leftSwipe(searchImageBox(currentBoxIndex),
                                 searchImageBox(currentBoxIndex+1));
      if(currentBoxIndex > 0) unloadImage(currentBoxIndex-1);
      loadImage(currentBoxIndex+2, LEFT);
      currentBoxIndex += 1;
    },
    goLeftImage : function(){
      Suzuka.Animation.rightSwipe(searchImageBox(currentBoxIndex),
                                  searchImageBox(currentBoxIndex-1));
      if(currentBoxIndex < imageFileList.length - 1)
        unloadImage(currentBoxIndex+1);
      loadImage(currentBoxIndex - 2, RIGHT);
      currentBoxIndex -= 1; 
    },
    hasRightImage : function(){
      return currentBoxIndex < imageFileList.length - 1;
    },
    hasLeftImage : function(){
      return currentBoxIndex > 0;
    }
  };
};