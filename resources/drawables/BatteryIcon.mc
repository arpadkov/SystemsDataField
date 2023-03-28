using Toybox.Graphics;
using Toybox.WatchUi;


class BatteryIcon extends WatchUi.Drawable  {

    var myBitmap;
    var posX;
    var posY;

    function initialize(params) {
        Drawable.initialize(params);

        posX = params.get(:posX);
        posY = params.get(:posY);

        myBitmap = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.BatteryIconBitMap,
            :locX=>posX,
            :locY=>posY
        });        
    }

    // Update the view
    function draw(dc) {
        myBitmap.draw(dc);      
    }

    // Change icon
    public function changeIcon() {
        myBitmap = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.BatteryIconBitMap2,
            :locX=>posX,
            :locY=>posY
        });
    }
}
