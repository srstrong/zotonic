{# Called by the action_unlink after removing an edge. Enables an undo of the action #}
<div class="notification error" id="{{ #notice }}">
	{% button text=_"undo" class="right" 
			action={link subject_id=subject_id predicate=predicate object_id=object_id action=action edge_template=edge_template}
			action={hide} 
			action={fade_out target=#notice} 
		%}
		
	{_ The page _} “{{m.rsc[object_id].title}}” {_ has been disconnected._}
</div>
