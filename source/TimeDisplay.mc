using Toybox.Graphics;
using Toybox.WatchUi;


class TimeDisplay extends WatchUi.Drawable  {

    hidden var clockIcon;
    hidden var text;

    hidden var minutes;
    hidden var hours;

    hidden var posXpercent;
    hidden var posYpercent;

    function initialize(params) {
        Drawable.initialize(params);

        posXpercent = params.get(:posX);
        posYpercent = params.get(:posY);
        var font = params.get(:font) as Graphics.FontReference;

        text = new WatchUi.Text({
            :text=>"AAA",
            :color=>Graphics.COLOR_BLACK,
            :font=>font
        });        

        clockIcon = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.clock
        });
    }

    // Update the view
    function draw(dc) {

        var posXclock = (dc.getWidth() * posXpercent) / 100;
        var posYclock = (dc.getHeight() * posYpercent) / 100;

        // var posXtext = (dc.getWidth() * posXpercent) / 100;
        var posYtext = posYclock + (clockIcon.height-text.height) / 2;

        text.setText(posYpercent.format("%.0f"));
        text.setLocation(posXclock, posYtext);
        text.draw(dc);

        clockIcon.setLocation(posXclock, posYclock);
        clockIcon.draw(dc); 
    }

    // Change icon
    // public function changeIcon() {
    //     myBitmap = new WatchUi.Bitmap({
    //         :rezId=>Rez.Drawables.BatteryIconBitMap2,
    //         :locX=>posX,
    //         :locY=>posY
    //     });
    // }
}