# Proof of Cconcept

When using terraform to create wafv2 ip sets and rule groups there exists a bug that prevents modification after resources are created.

If you have say 3 ip sets and 2 rules, configured something like this

```
Rule 1
    - set_alpha
    - set_bravo

Rule 2
    - set_charlie
```

And you have successfully planned and applied the code, remove set_bravo from Rule 1 and then try to plan again the plan will correctly show 1 item to be deleted
and 1 item to be modified. However when applying the changed code it tries to delete the ip set **before** the rule group. 

## Versions Tested

| version | present |  notes |
| ---- | ---- | ---- |
| 1.9.7 | :white_check_mark: | |
| 1.12.0 | :white_check_mark: | | 
| 1.12.1 | :white_check_mark: | |
