ci-setup:
	# cp -n .env.example .env || true
	yarn install
	RAILS_ENV=test bundle install --without production development
	chmod u+x bin/rails
 	bin/rails db:prepare
	# bin/rails db:fixtures:load

lint-code:
	bundle exec rubocop

lint-slim:
	bundle exec slim-lint app/views/

test:
	bin/rails test

.PHONY: test