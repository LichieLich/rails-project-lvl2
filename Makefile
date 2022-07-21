ci-setup:
	# cp -n .env.example .env || true
	yarn install
	bundle install --without production development
	RAILS_ENV=test bin/rails db:prepare
	# bin/rails db:fixtures:load

lint-code:
	bundle exec rubocop

lint-slim:
	bundle exec slim-lint app/views/

test:
	bin/rails test

.PHONY: test