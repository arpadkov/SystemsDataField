import Toybox.Activity;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

class SystemsDataFieldView extends WatchUi.DataField {

    hidden var batteryState as Numeric;
    var hours as Numeric;
    var minutes as Numeric;

    var obsVal as Numeric;

    function initialize() {
        DataField.initialize();

        batteryState = 0.0f;
        hours = 0.0f;
        minutes = 0.0f;

        obsVal = 0.0f;
    }

    // Set your layout here. Anytime the size of obscurity of
    // the draw context is changed this will be called.
    function onLayout(dc as Dc) as Void {
        var obscurityFlags = DataField.getObscurityFlags();

        // Top Layout
        if (obscurityFlags == (OBSCURE_RIGHT | OBSCURE_LEFT | OBSCURE_TOP)) {
            View.setLayout(Rez.Layouts.TopLayout(dc));
        }

        // Bottom Layout
        else if (obscurityFlags == (OBSCURE_RIGHT | OBSCURE_LEFT | OBSCURE_BOTTOM)) {
            View.setLayout(Rez.Layouts.BottomLayout(dc));
        }

        // Side Layout
        else if ((obscurityFlags == OBSCURE_RIGHT) || (obscurityFlags == OBSCURE_LEFT)) {
            View.setLayout(Rez.Layouts.SideLayout(dc));
        }

        // Top left quadrant so we'll use the top left layout
        else if (obscurityFlags == (OBSCURE_TOP | OBSCURE_LEFT)) {
            View.setLayout(Rez.Layouts.TopLeftLayout(dc));
        }

        // Top right quadrant so we'll use the top right layout
        else if (obscurityFlags == (OBSCURE_TOP | OBSCURE_RIGHT)) {
            View.setLayout(Rez.Layouts.TopRightLayout(dc));
        }

        // Bottom left quadrant so we'll use the bottom left layout
        else if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_LEFT)) {
            View.setLayout(Rez.Layouts.BottomLeftLayout(dc));
        }

        // Bottom right quadrant so we'll use the bottom right layout
        else if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_RIGHT)) {
            View.setLayout(Rez.Layouts.BottomRightLayout(dc));
        }

        // Use the generic, centered layout
        else {
            View.setLayout(Rez.Layouts.MainLayout(dc));
            // var labelView = View.findDrawableById("label");
            // labelView.locY = labelView.locY - 16;
            // var valueView = View.findDrawableById("batteryStateLabel");
            // valueView.locY = valueView.locY + 7;
        }

        //(View.findDrawableById("label") as Text).setText(Rez.Strings.label);

        obsVal = DataField.getObscurityFlags() as Numeric;
    }

    // The given info object contains all the current workout information.
    // Calculate a value and save it locally in this method.
    // Note that compute() and onUpdate() are asynchronous, and there is no
    // guarantee that compute() will be called before onUpdate().
    function compute(info as Activity.Info) as Void {
        // See Activity.Info in the documentation for available information.

        batteryState = System.getSystemStats().battery;
        hours = System.getClockTime().hour;
        minutes = System.getClockTime().min;

        // if(info has :currentHeartRate){
        //     if(info.currentHeartRate != null){
        //         batteryState = info.currentHeartRate as Number;
        //     } else {
        //         batteryState = 0.0f;
        //     }
        // }

        
    }

    // Display the value you computed here. This will be called
    // once a second when the data field is visible.
    function onUpdate(dc as Dc) as Void {
        // Set the background color
        (View.findDrawableById("Background") as Text).setColor(getBackgroundColor());

        // Set the foreground color and value for batteryStateLabel
        var batteryStateLabel = View.findDrawableById("batteryStateLabel") as Text;
        if (getBackgroundColor() == Graphics.COLOR_BLACK) {
            batteryStateLabel.setColor(Graphics.COLOR_WHITE);
        } else {
            batteryStateLabel.setColor(Graphics.COLOR_BLACK);
        }
        // batteryStateLabel.setText(batteryState.format("%.0f") + "%");
        batteryStateLabel.setText(batteryState.format("%.0f"));


        var timeDisplay = View.findDrawableById("timeDisplay") as TimeDisplay;
        timeDisplay.setTime(System.getClockTime());

        // Set the foreground color and value for timeLabel
        // var timeLabel = View.findDrawableById("timeLabel") as Text;
        // if (getBackgroundColor() == Graphics.COLOR_BLACK) {
        //     timeLabel.setColor(Graphics.COLOR_WHITE);
        // } else {
        //     timeLabel.setColor(Graphics.COLOR_BLACK);
        // }
        // timeLabel.setText(hours.format("%02d") + ":" + minutes.format("%02d"));

        // Change battery icon
        // var battery_icon = (findDrawableById("battery_bitmap_class") as BatteryIcon);
        // battery_icon.changeIcon();

        // Call parent's onUpdate(dc) to redraw the layout
        View.onUpdate(dc);
    }

}
