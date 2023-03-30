using Toybox.Graphics;
using Toybox.WatchUi;


class TimeDisplay extends WatchUi.Drawable  {

    hidden var clockIcon;
    hidden var text;

    hidden var minutes;
    hidden var hours;

    hidden var posXpercent;
    hidden var posYpercent;
    hidden var spacing;


    function initialize(params) {
        Drawable.initialize(params);

        posXpercent = params.get(:posX);
        posYpercent = params.get(:posY);
        spacing = params.get(:spacing);
        var font = params.get(:font) as Graphics.FontReference;     // fonts: https://developer.garmin.com/connect-iq/api-docs/Toybox/Graphics.html
        var iconSize = params.get(:iconSize);

        text = new WatchUi.Text({
            // :text=>"AAA",
            :color=>Graphics.COLOR_BLACK,
            :font=>font
        });        

        setClockIcon(iconSize);
    }

    // Update the view
    function draw(dc) {
        var posXclock = (dc.getWidth() * posXpercent) / 100;
        var posYclock = (dc.getHeight() * posYpercent) / 100;

        var posXtext = posXclock + spacing + clockIcon.width;
        var posYtext = posYclock + (clockIcon.height-text.height) / 2;

        // text.setText(posYpercent.format("%.0f"));
        text.setLocation(posXtext, posYtext);
        text.draw(dc);

        clockIcon.setLocation(posXclock, posYclock);
        clockIcon.draw(dc); 
    }

    function setTime(time) {
        text.setText(time.hour.format("%02d") +":" + time.min.format("%02d"));
    }

    function setClockIcon(iconSize) {
        if (iconSize == 60) {
            clockIcon = new WatchUi.Bitmap({ :rezId=>Rez.Drawables.clock_60 });
        }
        else if (iconSize == 40) {
            clockIcon = new WatchUi.Bitmap({ :rezId=>Rez.Drawables.clock_40 });
        }
        else if (iconSize == 30) {
            clockIcon = new WatchUi.Bitmap({ :rezId=>Rez.Drawables.clock_30 });
        }
        else {
            clockIcon = new WatchUi.Bitmap({ :rezId=>Rez.Drawables.clock_20 });
        }
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