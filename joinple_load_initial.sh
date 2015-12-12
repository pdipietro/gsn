
cd $HOME/joinple

sudo mkdir ./db/neo4j/data/log

sudo chown -R $USER:$USER ./db/neo4j/data/log ./db/neo4j/data/graph.db ./db/neo4j/data/log/db_load.log ./db/neo4j/data/log/db_load_stderr.log

sudo cat ./db/joinple_load_initial.txt | ./db/neo4j/bin/neo4j-shell neo4j.properties -path ./db/neo4j/data/graph.db > ./db/neo4j/data/log/db_load.log   2>./db/neo4j/data/log/db_load_stderr.log

sudo chown -R $USER:$USER ./db/neo4j/data/log ./db/neo4j/data/graph.db ./db/neo4j/data/log/db_load.log ./db/neo4j/data/log/db_load_stderr.log

sudo chmod -R 777 ./db/neo4j/data/log ./db/neo4j/data/graph.db ./db/neo4j/data/log/db_load.log ./db/neo4j/data/log/db_load_stderr.log
