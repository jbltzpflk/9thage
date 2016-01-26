jruby attrhelp.rb <data/attr_help.txt >data/attr_help.yaml
jruby -e "require 'yaml'; d = YAML.load STDIN.read; puts YAML.dump d" < data/attr_help.yaml >d.yaml
diff d.yaml data/attr_help.yaml
