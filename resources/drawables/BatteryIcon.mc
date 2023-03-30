using Toybox.Graphics;
using Toybox.WatchUi;


class BatteryIcon extends WatchUi.Drawable  {

    var myBitmap;
    var posXpercent;
    var posYpercent;

    var posX;
    var posY;

    function initialize(params) {
        Drawable.initialize(params);

        posXpercent = params.get(:posX);
        posYpercent = params.get(:posY);

        myBitmap = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.BatteryIconBitMap
        });
   
    }

    // Update the view
    function draw(dc) {
        // var width = dc.getWidth();

        posX = (dc.getWidth() * posXpercent) / 100;
        posY = (dc.getHeight() * posYpercent) / 100;

        myBitmap.setLocation(posX, posY);
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
