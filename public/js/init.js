var imageBoxList;
var currentBoxIndex = 0;

var loadEmptyImageBoxes = function(){
  for(var i = 0; i < imageFileList.length; i++){
    var imageBox = $("<div>").addClass("image-box").append($("<img>").attr("src", "").addClass("image"));
    $("#swipe-box").append(imageBox);
  }
};

var loadInitialImages = function(){
  loadImage(0);
  loadImage(1);
};

var loadImage = function(i){
  $(".image-box img")[i].src = imageFileList[i];
  console.log("load: " + i);
};

var unloadImage = function(i){
  $(".image-box img")[i].src = "";
  console.log("unload: " + i);
};

var setupImageBox = function(){
    imageBoxList = $(".image-box");
    var width = $(window).width();
    
    for(var i = 0; i < imageBoxList.length; i++){
      Suzuka.Animation.moveX($(imageBoxList[i]), width * i);
      $(imageBoxList[i]).show();
    }

    Suzuka.Swipe.detector( $("#swipe-box"), {
      onLeftSwipe : function(){
        if(currentBoxIndex < imageBoxList.length - 1) {
          Suzuka.Animation.leftSwipe($(imageBoxList[currentBoxIndex]),
                                     $(imageBoxList[currentBoxIndex+1]));
          if(currentBoxIndex > 0) unloadImage(currentBoxIndex-1);
          loadImage(currentBoxIndex+2);
          currentBoxIndex += 1;
        }
      },
      onRightSwipe : function(){
        if(currentBoxIndex > 0) {
          Suzuka.Animation.rightSwipe($(imageBoxList[currentBoxIndex]),
                                      $(imageBoxList[currentBoxIndex-1]));
          if(currentBoxIndex < imageBoxList.length - 1)
            unloadImage(currentBoxIndex+1);
          loadImage(currentBoxIndex - 2);
          currentBoxIndex -= 1;
        }
      }
    });
  };

$(function(){
  loadEmptyImageBoxes();
  loadInitialImages();
  setupImageBox();
});