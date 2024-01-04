package hxchatgpt;

class HxPromise<T> {
	var callback:T->Void;

	var isFulfilled:Bool = false;
	var fulfilledData:T;

	public function new() {}

	public function listen(cb:T->Void) {
		this.callback = cb;
		check();
	}

	public function fulfill(data:T) {
		isFulfilled = true;
		fulfilledData = data;
		if (callback != null) {
			callback(fulfilledData);
		}
	}

	public function check():Void {
		if (isFulfilled) {
			this.callback(fulfilledData);
		}
	}
}
