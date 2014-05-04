bamt_install:
	if [ -e "/etc/bamt" ]; \
	then \
	   mv ./cgminer.conf /etc/bamt ; \
	fi

create_cgminer:
	touch cgminer.conf
	cat cgminer.start > cgminer.conf
	python generate_config.py >> cgminer.conf

install: create_cgminer bamt_install
