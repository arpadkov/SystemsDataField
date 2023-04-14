using Toybox.Graphics;
using Toybox.WatchUi;

class GpsStrengthDisplay extends WatchUi.Drawable  {

    var posXpercent;
    var posYpercent;
    hidden var spacing;
    hidden var heightIncrement;
    hidden var width;

    hidden var color;

    hidden var signalStrength;
    hidden var maxStrength;

    function initialize(params) {
        Drawable.initialize(params);

        posXpercent = params.get(:posX);
        posYpercent = params.get(:posY);
        spacing = params.get(:spacing);
        heightIncrement = params.get(:heightIncrement);
        width = params.get(:width);

        maxStrength = 4;
        signalStrength = 4;
    }

    // Update the view
    function draw(dc) {
        dc.setColor(color, Graphics.COLOR_BLACK); // Second argument is background color, but seems to have no effect
        
        var posX = (dc.getWidth() * posXpercent) / 100;
        var posY = (dc.getHeight() * posYpercent) / 100;

        var maxHeight = heightIncrement * maxStrength;
        
        for (var i = 0; i < signalStrength; i++) {
            var height = heightIncrement * (i + 1);
            var adjustedPosY = posY + maxHeight - (heightIncrement * (i + 1));
            dc.fillRectangle(posX + i * (width + spacing), adjustedPosY, width, height);
        }
    }

    function setColor(backgroundColor)
    {
        if (backgroundColor == Graphics.COLOR_BLACK) {
            color = Graphics.COLOR_WHITE;
        } else {
            color = Graphics.COLOR_BLACK;
        }
    }

    function setSignalStrength(strength) {
        signalStrength = strength;
    }

}