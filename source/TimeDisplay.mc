using Toybox.Graphics;
using Toybox.WatchUi;


class TimeDisplay extends WatchUi.Drawable  {

    hidden var clockIcon;
    hidden var text;

    hidden var posXpercent;
    hidden var posYpercent;
    hidden var spacing;
    hidden var size;

    hidden var textHeight;

    function initialize(params) {
        Drawable.initialize(params);

        posXpercent = params.get(:posX);
        posYpercent = params.get(:posY);
        spacing = params.get(:spacing);
        size = params.get(:size);

        text = new WatchUi.Text({
            :text=>"",
            :color=>Graphics.COLOR_BLACK,
        });  
    }

    // Update the view
    function draw(dc) {
        setTime(System.getClockTime());
        setSizes(size);
        setPosition(dc);

        clockIcon.draw(dc);
        text.draw(dc);
    }

    function setSizes(size) {
        // fonts: https://developer.garmin.com/connect-iq/api-docs/Toybox/Graphics.html
        if (size == 1) {
            text.setFont(1 as Graphics.FontReference);
            textHeight = 26;
            setClockIcon(20);
        }
        else if (size == 2) {
            text.setFont(2 as Graphics.FontReference);
            textHeight = 29;
            setClockIcon(20);
        }
        else if (size == 3) {
            text.setFont(2 as Graphics.FontReference);
            textHeight = 34;
            setClockIcon(40);
        }
        else if (size == 4) {
            text.setFont(4 as Graphics.FontReference);
            textHeight = 37;
            setClockIcon(40);
        }
    }

    function setTime(time) {
        text.setText(time.hour.format("%02d") +":" + time.min.format("%02d"));
    }

    function setPosition(dc) {
        var posXclock = (dc.getWidth() * posXpercent) / 100;
        var posYclock = (dc.getHeight() * posYpercent) / 100;

        var posXtext = posXclock + spacing + clockIcon.width; 
        var posYtext = posYclock + (clockIcon.height-textHeight) / 2;

        clockIcon.setLocation(posXclock, posYclock);
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