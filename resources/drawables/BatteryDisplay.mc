using Toybox.Graphics;
using Toybox.WatchUi;

// TODO: create superclass: Icon-Label-Display for BatteryDisplay&TimeDisplay
class BatteryDisplay extends WatchUi.Drawable  {

    hidden var batteryIcon;
    hidden var text;

    var posXpercent;
    var posYpercent;
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
        // var width = dc.getWidth();
        setBatteryState();
        setSizes(size);
        setPosition(dc);

        batteryIcon.draw(dc);
        text.draw(dc);
    }

    function setSizes(size) {
        // fonts: https://developer.garmin.com/connect-iq/api-docs/Toybox/Graphics.html
        if (size == 1) {
            text.setFont(1 as Graphics.FontReference);
            textHeight = 26;
            setBatteryIcon(20);
        }
        else if (size == 2) {
            text.setFont(2 as Graphics.FontReference);
            textHeight = 29;
            setBatteryIcon(20);
        }
        else if (size == 3) {
            text.setFont(2 as Graphics.FontReference);
            textHeight = 34;
            setBatteryIcon(40);
        }
        else if (size == 4) {
            text.setFont(4 as Graphics.FontReference);
            textHeight = 37;
            setBatteryIcon(40);
        }
    }

    function setBatteryState() {
        text.setText(System.getSystemStats().battery.format("%.0f") + "%");
        var x =5;
    }

     function setPosition(dc) {
        var posXicon = (dc.getWidth() * posXpercent) / 100;
        var posYicon = (dc.getHeight() * posYpercent) / 100;

        var posXtext = posXicon + spacing + batteryIcon.width; 
        var posYtext = posYicon + (batteryIcon.height-textHeight) / 2;

        batteryIcon.setLocation(posXicon, posYicon);
        text.setLocation(posXtext, posYtext);
    }

    function setBatteryIcon(iconSize) {
        if (iconSize == 60) {
            batteryIcon = new WatchUi.Bitmap({ :rezId=>Rez.Drawables.clock_60 });
        }
        else if (iconSize == 40) {
            batteryIcon = new WatchUi.Bitmap({ :rezId=>Rez.Drawables.clock_40 });
        }
        else if (iconSize == 30) {
            batteryIcon = new WatchUi.Bitmap({ :rezId=>Rez.Drawables.clock_30 });
        }
        else {
            batteryIcon = new WatchUi.Bitmap({ :rezId=>Rez.Drawables.clock_20 });
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
