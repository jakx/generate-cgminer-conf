bamt_install:
	if [ -e "/etc/bamt" ]; \
	then \
	   mv ./cgminer.conf /etc/bamt ; \
	fi

create_cgminer:
	./generate_config.sh

install: create_cgminer bamt_install
