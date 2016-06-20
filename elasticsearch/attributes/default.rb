# Encoding: utf-8


default['elastic']['version']         = '1.5.2'
default['elastic']['source_url']     = 'http://packages.elastic.co/elasticsearch/1.5/debian'
default['elastic']['component']      =  %w(stable main)
default['elastic']['key']            = 'https://packages.elastic.co/GPG-KEY-elasticsearch'
default['elastic']['apt']['action']  = :add

# Elasticsearch.yml file core configurations. 
default['elastic']['cluster']['name']                                  = 'elasticsearch'
default['elastic']['http']['cors']['enabled']                          = 'true'
default['elastic']['http']['cors']['allow-origin']                     = '*'    #Make it double quoted in elasticsearch.yml.erb file
default['elastic']['discovery']['zen']['ping']['multicast']['enabled'] = 'false'
default['elastic']['discovery']['zen']['ping']['unicast']['hosts']     = '[]'
default['elastic']['index']['number_of_shards']                        = '5'
default['elastic']['index']['number_of_replicas']                      = '1'