ci-setup:
	# cp -n .env.example .env || true
	yarn install
	RAILS_ENV=test bundle install --without production development
	chmod u+x bin/rails
 	bin/rails db:prepare
	# bin/rails db:fixtures:load

setup:
	# cp -n .env.example .env || true
	bin/setup
	bin/rails db:fixtures:load
	npx simple-git-hooks

lint-code:
	bundle exec rubocop

lint-slim:
	bundle exec slim-lint app/views/

start:
	bin/rails s

test:
	bin/rails test

.PHONY: test