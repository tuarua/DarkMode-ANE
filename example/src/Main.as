package {

import com.tuarua.DarkMode;
import com.tuarua.FreSwift;

import flash.desktop.NativeApplication;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.AntiAliasType;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;

import views.SimpleButton;

[SWF(width="800", height="600", frameRate="60", backgroundColor="#FFFFFF")]
public class Main extends Sprite {
    private var freSwiftANE:FreSwift = new FreSwift();
    public static const FONT:Font = new FiraSansSemiBold();
    private var hasActivated:Boolean;
    private var statusLabel:TextField = new TextField();
    private var btnToggle:SimpleButton = new SimpleButton("Toggle Dark Mode");
    private var isDarkModeToggled:Boolean = false;

    public function Main() {
        super();
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;

        var tf:TextFormat = new TextFormat(Main.FONT.fontName, 13, 0x222222);
        tf.align = "center";

        statusLabel.defaultTextFormat = tf;
        statusLabel.width = stage.stageWidth;
        statusLabel.y = 75;
        statusLabel.wordWrap = statusLabel.multiline = false;
        statusLabel.selectable = false;
        statusLabel.embedFonts = true;
        statusLabel.antiAliasType = AntiAliasType.ADVANCED;
        statusLabel.sharpness = -100;
        addChild(statusLabel);

        btnToggle.x = (stage.stageWidth - 200) * 0.5;
        btnToggle.y = statusLabel.y + 75;
        btnToggle.addEventListener(MouseEvent.CLICK, onToggleClick);

        addChild(btnToggle);

        NativeApplication.nativeApplication.addEventListener(Event.EXITING, onExiting);
        this.addEventListener(Event.ACTIVATE, onActivated);
    }

    private function onActivated(event:Event):void {
        if (hasActivated) return;
        if (!DarkMode.isAvailable) {
            statusLabel.text = "Dark mode is not available";
            return;
        }
        statusLabel.text = "User has set the Appearance to: " + (DarkMode.isEnabled ? "Dark" : "Light");
        hasActivated = true;
    }

    private function onToggleClick(event:MouseEvent):void {
        isDarkModeToggled = !isDarkModeToggled;
        DarkMode.isEnabled = isDarkModeToggled;
    }

    private function onExiting(event:Event):void {
        DarkMode.dispose();
        FreSwift.dispose();
    }
}
}
