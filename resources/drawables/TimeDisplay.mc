using Toybox.Graphics;
using Toybox.WatchUi;


class TimeDisplay extends WatchUi.Drawable  {

    hidden var clockIcon;
    hidden var text;

    hidden var posXpercent;
    hidden var posYpercent;
    hidden var spacing;
    hidden var size;
    hidden var color;

    hidden var textHeight;

    function initialize(params) {
        Drawable.initialize(params);

        posXpercent = params.get(:posX);
        posYpercent = params.get(:posY);
        spacing = params.get(:spacing);
        size = params.get(:size);

        text = new WatchUi.Text({
            :text=>"",
            // :color=>Graphics.COLOR_BLACK,
        });  
    }

    // Update the view
    function draw(dc) {
        setTime(System.getClockTime());
        setSizes();
        text.setColor(color);
        setPosition(dc);

        clockIcon.draw(dc);
        text.draw(dc);
    }

    // Sets color based on background color
    function setColor(backgroundColor)
    {
        if (backgroundColor == Graphics.COLOR_BLACK) {
            color = Graphics.COLOR_WHITE;
        } else {
            color = Graphics.COLOR_BLACK;
        }
    }

    function setSizes() {
        // fonts: https://developer.garmin.com/connect-iq/api-docs/Toybox/Graphics.html
        if (size == 1) {
            text.setFont(1 as Graphics.FontReference);
            textHeight = 26;
            setClockIcon();
        }
        else if (size == 2) {
            text.setFont(2 as Graphics.FontReference);
            textHeight = 29;
            setClockIcon();
        }
        else if (size == 3) {
            text.setFont(2 as Graphics.FontReference);
            textHeight = 34;
            setClockIcon();
        }
        else if (size == 4) {
            text.setFont(4 as Graphics.FontReference);
            textHeight = 37;
            setClockIcon();
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

    function setClockIcon() {
        if (color == Graphics.COLOR_BLACK) {
            if (size < 3) {
                clockIcon = new WatchUi.Bitmap({ :rezId=>Rez.Drawables.clock_small_black });
            }
            else {
                clockIcon = new WatchUi.Bitmap({ :rezId=>Rez.Drawables.clock_big_black });
            }
        }

        else {
            if (size < 3) {
                clockIcon = new WatchUi.Bitmap({ :rezId=>Rez.Drawables.clock_small_white });
            }
            else {
                clockIcon = new WatchUi.Bitmap({ :rezId=>Rez.Drawables.clock_big_white });
            }
        }


        // if (iconSize == 60) {
        //     clockIcon = new WatchUi.Bitmap({ :rezId=>Rez.Drawables.clock_60 });
        // }
        // else if (iconSize == 40) {
        //     clockIcon = new WatchUi.Bitmap({ :rezId=>Rez.Drawables.clock_40 });
        // }
        // else if (iconSize == 30) {
        //     clockIcon = new WatchUi.Bitmap({ :rezId=>Rez.Drawables.clock_30 });
        // }
        // else {
        //     clockIcon = new WatchUi.Bitmap({ :rezId=>Rez.Drawables.clock_20 });
        // }
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