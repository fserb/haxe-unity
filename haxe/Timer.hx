/*
 * Copyright (c) 2005, The haXe Project Contributors
 * All rights reserved.
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *   - Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *   - Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE HAXE PROJECT CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE HAXE PROJECT CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
 * DAMAGE.
 */
package haxe;

#if cs
import cs.system.DateTime;
import cs.system.Object;
import cs.system.timers.ElapsedEventArgs;
import cs.system.timers.ElapsedEventHandler;
import cs.system.TimeSpan;
/**
	The Timer class allows you to create asynchronous timers on platforms that support events.
**/
class Timer {
	private var t:cs.system.timers.Timer;
	private var id : Null<Int>;
	private function runRun():Void run();

	/**
		Create a new timer that will run every [time_ms] (in milliseconds).
	**/
	public function new( time_ms : Int ) {
		id = 1;
		var f = runRun;
		var tt = t = new cs.system.timers.Timer(time_ms);
		t.Enabled = true;
		untyped __cs__("tt.Elapsed+=delegate(System.Object o, System.Timers.ElapsedEventArgs e){f.__hx_invoke0_o();}");
	}

	/**
		Stop the timer definitely.
	**/
	public function stop() {
		if( id == null )
			return;
		t.Stop();
		t.Enabled = false;
		t = null;
		id = null;
	}

	/**
		This is the [run()] method that is called when the Timer executes. It can be either overriden in subclasses or directly rebinded with another function-value.
	**/
	public dynamic function run() {
		trace("run");
	}

	/**
		This will delay the call to [f] for the given time. [f] will only be called once.
	**/
	public static function delay( f : Void -> Void, time_ms : Int ) {
		var t = new haxe.Timer(time_ms);
		t.run = function() {
			t.stop();
			f();
		};
		return t;
	}

	/**
		Measure the time it takes to execute the function [f] and trace it. Returns the value returned by [f].
	**/
	public static function measure<T>( f : Void -> T, ?pos : PosInfos ) : T {
		var t0 = stamp();
		var r = f();
		Log.trace((stamp() - t0) + "s", pos);
		return r;
	}

	/**
		Returns the most precise timestamp, in seconds. The value itself might differ depending on platforms, only differences between two values make sense.
	**/
	public static function stamp() : Float {
		var ts:TimeSpan = null;
		ts = untyped __cs__('System.DateTime.UtcNow - new System.DateTime(1970, 1, 1)');
		return ts.TotalMilliseconds;
	}
}
#end
