var setupImageBox = function(){
  var imageBox = Suzuka.ImageBox( $("#swipe-box"), imageFileList );
  imageBox.setCurrentIndex(0);
  
  Suzuka.Swipe.detector( $("#swipe-box"), {
    onLeftSwipe : function(){
      if(imageBox.hasRightImage()) {
        imageBox.goRightImage();
      }
    },
    onRightSwipe : function(){
      if(imageBox.hasLeftImage()) {
        imageBox.goLeftImage();
      }
    }
  });
};

$(function(){
  setupImageBox();
});