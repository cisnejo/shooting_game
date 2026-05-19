class_name HitboxFrameData 
extends Resource

# Each entry: { "animation": "attack", "start": 3, "end": 5 }
@export var entries: Array[HitboxFrameEntry] = []

func is_active(animation: StringName, frame: int) -> bool:
	for entry in entries:
		if entry.animation == animation:
			return frame >= entry.start_frame and frame <= entry.end_frame
	return false
