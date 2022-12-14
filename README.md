# Sales-Dashboard

[DASHBOARD](https://public.tableau.com/views/SALESDASHBOARD_16710058332310/Dashboard?:language=en-US&:display_count=n&:origin=viz_share_link)

<div class='tableauPlaceholder' id='viz1671010103140' style='position: relative'><noscript><a href='#'><img alt='Dashboard ' src='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;SA&#47;SALESDASHBOARD_16710058332310&#47;Dashboard&#47;1_rss.png' style='border: none' /></a></noscript><object class='tableauViz'  style='display:none;'><param name='host_url' value='https%3A%2F%2Fpublic.tableau.com%2F' /> <param name='embed_code_version' value='3' /> <param name='path' value='views&#47;SALESDASHBOARD_16710058332310&#47;Dashboard?:language=en-US&amp;:embed=true' /> <param name='toolbar' value='yes' /><param name='static_image' value='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;SA&#47;SALESDASHBOARD_16710058332310&#47;Dashboard&#47;1.png' /> <param name='animate_transition' value='yes' /><param name='display_static_image' value='yes' /><param name='display_spinner' value='yes' /><param name='display_overlay' value='yes' /><param name='display_count' value='yes' /><param name='language' value='en-US' /></object></div>

##

A dbt project for creating sales insights in SQL and visualizing results using Tableau.

## Instructions

#### Move into top-level directory
```
cd Sales-Dashboard
```

#### Install environment
```
conda env create -f environment.yml
```

#### Activate environment
```
conda activate sales
```

#### Build models
```
dbt run
```

#### Run tests
```
dbt test
```
