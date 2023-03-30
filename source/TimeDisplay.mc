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

    hidden var posXclock;
    hidden var posYclock;

    hidden var font;


    function initialize(params) {
        Drawable.initialize(params);

        posXpercent = params.get(:posX);
        posYpercent = params.get(:posY);
        spacing = params.get(:spacing);
        font = params.get(:font) as Graphics.FontReference;     // fonts: https://developer.garmin.com/connect-iq/api-docs/Toybox/Graphics.html
        
        var iconSize = params.get(:iconSize);

        text = new WatchUi.Text({
            :text=>"",
            :color=>Graphics.COLOR_BLACK,
            :font=>font
        });        

        setClockIcon(iconSize);
    }

    // Update the view
    function draw(dc) {
        // text = new WatchUi.Text({
        //     :text=>"",
        //     :color=>Graphics.COLOR_BLACK,
        //     :font=>font
        // }); 

        setTime(System.getClockTime());
        positionClock(dc);
        clockIcon.draw(dc); 


        positionText(); // Not working: height of text is only calculated after drawing it
        text.draw(dc);
        var x = 5;
    }

    function setTime(time) {
        text.setText(time.hour.format("%02d") +":" + time.min.format("%02d"));
    }

    function positionClock(dc) {
        posXclock = (dc.getWidth() * posXpercent) / 100;
        posYclock = (dc.getHeight() * posYpercent) / 100;

        clockIcon.setLocation(posXclock, posYclock);
    }

    function positionText() {
        var posXtext = posXclock + spacing + clockIcon.width;  

        // var posYtext = posYclock + (clockIcon.height-text.height) / 2;
        var h1 = clockIcon.height;
        var h2 = text.height;
        // var x = (h1-h2) / 2;
        var x = (h2-h1) / 2;
        var posYtext = posYclock + x;

        // text.setText(posYpercent.format("%.0f"));
        // text.setLocation(posXtext, posYtext);
        text.setLocation(posXtext, posYtext);
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