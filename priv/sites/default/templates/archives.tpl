{% extends "base.tpl" %}

{% block title %}Archives{% endblock %}

{% block chapeau %}
	<h5 class="chapeau">Archives for {% if q.month %}{{ q.month }}, {% endif %}{{ q.year }}</h5>
{% endblock %}

{% block content %}
	
	{% with m.search.paged[{query publication_year=q.year publication_month=q.month sort='-publication_start' cat=cat page=q.page pagelen=m.config.site.pagelen.value}] as result %}
		
		{% for id in result %}
			
			{% include "_article_summary.tpl" id=id %}
		
		{% endfor %}
	
		{% pager result=result dispatch='archives_y' year=q.year %}

	{% endwith %}

{% endblock %}