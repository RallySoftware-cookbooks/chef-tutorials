## Description
This cookbook will provide examples on how and when to use search within your cookbooks. Each recipe will also have tests that show how to test the given search scenario.

## Recipes
### Environment Search
This recipe exercises performing a search for nodes in different environments and then writes those results to disk using the template resource. Chef environments are very flexiable and can be used as logical divisions of systems within your chef server. You could choose to have environments based on location or class (production, test, staging, dev...). Whatever your divison may be, being able to find all nodes within that environment is very useful. 

## License
Copyright (C) 2013 Rally Software Development Corp

Distributed under the MIT License.
