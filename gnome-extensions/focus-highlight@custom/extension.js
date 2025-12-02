'use strict';

import St from 'gi://St';
import Meta from 'gi://Meta';
import * as Main from 'resource:///org/gnome/shell/ui/main.js';
import {Extension} from 'resource:///org/gnome/shell/extensions/extension.js';

export default class FocusHighlight extends Extension {
    constructor(metadata) {
        super(metadata);
        this._border = null;
        this._focusSignal = null;
        this._positionSignal = null;
        this._sizeSignal = null;
        this._currentWindow = null;
    }

    _createBorder() {
        this._border = new St.Widget({
            style: `
                border: 3px solid #ff7733;
                border-radius: 12px;
            `,
            reactive: false,
            can_focus: false,
        });
        global.window_group.add_child(this._border);
    }

    _updateBorder() {
        const window = global.display.focus_window;

        if (!window || window.is_hidden() || window.get_window_type() !== Meta.WindowType.NORMAL) {
            if (this._border) {
                this._border.hide();
            }
            this._disconnectWindowSignals();
            this._currentWindow = null;
            return;
        }

        if (this._currentWindow !== window) {
            this._disconnectWindowSignals();
            this._currentWindow = window;
            this._connectWindowSignals(window);
        }

        const rect = window.get_frame_rect();
        const padding = 1;

        this._border.set_position(rect.x + padding, rect.y + padding);
        this._border.set_size(rect.width - padding * 2, rect.height - padding * 2);
        this._border.show();

        // Ensure border is above windows
        global.window_group.set_child_above_sibling(this._border, null);
    }

    _connectWindowSignals(window) {
        const actor = window.get_compositor_private();
        if (actor) {
            this._positionSignal = actor.connect('notify::position', () => this._updateBorder());
            this._sizeSignal = actor.connect('notify::size', () => this._updateBorder());
        }
    }

    _disconnectWindowSignals() {
        if (this._currentWindow) {
            const actor = this._currentWindow.get_compositor_private();
            if (actor) {
                if (this._positionSignal) {
                    actor.disconnect(this._positionSignal);
                    this._positionSignal = null;
                }
                if (this._sizeSignal) {
                    actor.disconnect(this._sizeSignal);
                    this._sizeSignal = null;
                }
            }
        }
    }

    enable() {
        this._createBorder();
        this._focusSignal = global.display.connect('notify::focus-window', () => this._updateBorder());
        // Initial update
        this._updateBorder();
    }

    disable() {
        if (this._focusSignal) {
            global.display.disconnect(this._focusSignal);
            this._focusSignal = null;
        }

        this._disconnectWindowSignals();
        this._currentWindow = null;

        if (this._border) {
            this._border.destroy();
            this._border = null;
        }
    }
}
