package kha.graphics4;

import kha.arrays.Float32Array;
import kha.graphics4.VertexData;
import kha.graphics4.VertexElement;
import kha.graphics4.VertexStructure;

class VertexBuffer {
	public var _buffer: Pointer;
	
	public function new(vertexCount: Int, structure: VertexStructure, usage: Usage, instanceDataStepRate: Int = 0, canRead: Bool = false) {
		var structure2 = kore_create_vertexstructure();
		for (i in 0...structure.size()) {
			var data: Int = 0;
			switch (structure.get(i).data.getIndex()) {
			case 0:
				data = 1;
			case 1:
				data = 2;
			case 2:
				data = 3;
			case 3:
				data = 4;
			case 4:
				data = 5;
			}
			kore_vertexstructure_add(structure2, StringHelper.convert(structure.get(i).name), data);
		}
		_buffer = kore_create_vertexbuffer(vertexCount, structure2, instanceDataStepRate);
	}

	public function delete() {
		kore_delete_vertexbuffer(_buffer);
	}
	
	public function lock(?start: Int, ?count: Int): Float32Array {
		var f32array = new Float32Array();
		f32array.setData(kore_vertexbuffer_lock(_buffer), this.count() * Std.int(stride() / 4));
		return f32array;
	}
	
	public function unlock(): Void {
		kore_vertexbuffer_unlock(_buffer);
	}
	
	public function stride(): Int {
		return kore_vertexbuffer_stride(_buffer);
	}
	
	public function count(): Int {
		return kore_vertexbuffer_count(_buffer);
	}
	
	@:hlNative("std", "kore_create_vertexstructure") public static function kore_create_vertexstructure(): Pointer { return null; }
	@:hlNative("std", "kore_vertexstructure_add") public static function kore_vertexstructure_add(structure: Pointer, name: hl.Bytes, data: Int): Void { }
	@:hlNative("std", "kore_create_vertexbuffer") static function kore_create_vertexbuffer(vertexCount: Int, structure: Pointer, stepRate: Int): Pointer { return null; }
	@:hlNative("std", "kore_delete_vertexbuffer") static function kore_delete_vertexbuffer(buffer: Pointer): Void { }
	@:hlNative("std", "kore_vertexbuffer_lock") static function kore_vertexbuffer_lock(buffer: Pointer): Pointer { return null; }
	@:hlNative("std", "kore_vertexbuffer_unlock") static function kore_vertexbuffer_unlock(buffer: Pointer): Void { }
	@:hlNative("std", "kore_vertexbuffer_stride") static function kore_vertexbuffer_stride(buffer: Pointer): Int { return 0; }
	@:hlNative("std", "kore_vertexbuffer_count") static function kore_vertexbuffer_count(buffer: Pointer): Int { return 0; }
}
