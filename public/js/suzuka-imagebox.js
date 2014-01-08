Suzuka.ImageBox = function(div, imageFileList){
  var LEFT = 1, RIGHT = -1, CENTER = 0;
  var currentBoxIndex = 0;

  var pixelRetio = function(){
    if(window.devicePixelRatio) {
      return window.devicePixelRatio;
    } else {
      return 1;
    }
  };

  var imageURL = function(url, printSize){
    var w = Math.ceil(printSize.width * pixelRetio());
    var h = Math.ceil(printSize.height * pixelRetio());
    return url + "?w=" + w + "&h=" + h;
  };
  
  var createEmptyImageBox = function(i){
    var url = imageFileList[i].path;
    var rawSize = imageFileList[i].size;
    var imagebox = $("<div>").addClass("image-box");
    var printSize = sizing(rawSize, $(window));
    var img = $("<img>").css({
      "width"  : printSize.width,
      "height" : printSize.height
    }).attr("src", imageURL(url, printSize));
    return imagebox.append(img).attr("id", "image-box-" + i);
  };

  var loadImage = function(i, direction){
    var width = $(window).width();
    var imageBox = createEmptyImageBox(i);
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

  var sizing = function(img, fit){
    var scale;
    var wscale = fit.width() / img.width;
    var hscale = fit.height() / img.height;
    scale = (fit.height() < img.height * wscale) ? hscale : wscale;
    return { "width"  : Math.ceil(img.width * scale),
             "height" : Math.ceil(img.height * scale)};
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