var imageBox;

var setupImageBox = function(){
  imageBox = Suzuka.ImageBox( $("#swipe-box"), imageFileList );
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

var createEmptySlotItem = function(url, k){
  return $("<div>").addClass("slot-item").attr("data-image-index", k)
    .append($("<img>").attr("src", url));
};

var loadSlot = function(){
  var items = [];
  for(var i = 0; i < 31; i++){
    var k = Math.floor( (slotFileList.length / 31) * i);
    var item = createEmptySlotItem(slotFileList[k], k);
    items.push(item);
  }
  $("#slot-box").append(items);
  $("#slot-box div").bind("click", function(event){
    var page = $(this).attr("data-image-index");
    imageBox.setCurrentIndex(parseInt(page, 10));
  });
};

var removeSlot = function(){
  $("#slot-box div").remove();  
};

var slotDisplay = false;

var setupSlot = function(){
  $("#swipe-box").bind('click', function(){
    if(slotDisplay) {
      removeSlot();
      slotDisplay = false;
    } else {
      loadSlot();
      slotDisplay = true;
    }
  });  
};

$(function(){
  setupImageBox();
  setupSlot();
});