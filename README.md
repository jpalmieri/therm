# Therm [WIP]

A simple temperature management API. I plan to use this for home brewing beer, but it's simple enough to be applied in a variety of ways.

# Local development

1. Clone repo, and cd into directory:
```
git clone https://github.com/jpalmieri/therm && cd therm
```
1. Remove my encrypted credentials (you'll be using your own)
```
rm config/credentials.yml.enc
```
1. Create a credentials key and encrypted file:
```
bin/rails credentials:edit
```
And exit the editor to save the encrypted secret key base. You should save the master key somewhere, per the displayed message. For more info:
http://guides.rubyonrails.org/5_2_release_notes.html#credentials

1. Setup the database:
```
bundle exec rails db:setup
```

1. Start the development server:
```
bundle exec rails s
```

Now you can create an account by submitting a POST request to `:3000/signup`. Here's an example using [HTTPie](https://httpie.org/):

```
http :3000/signup name="Gregory Hill" \
email="malaclypse@discordia.org" password="fnord" \
password_confirmation="fnord"
```

The response should include your authentication token, which should be added to the `Authorization` header of subsequent requests. If you want to play around via the command line, you can export the token: `export AUTH_TOKEN="XXXXXXX"`

Other endpoints:
* GET /projects
* GET /projects/:id
* POST /projects
* PUT /projects/:id
* DELETE /projects/:id
* GET /projects/:project_id/temps
* GET /projects/:project_id/temps/:id
* POST /projects/:project_id/temps
* PUT /projects/:project_id/temps/:id
* DELETE /projects/:project_id/temps/:id

As you can see, Temps (logged temperatures) are nested within Projects, so you'll have to create your first project before being able to log temperatures:

```
http POST :3000/projects name="Fermentation chamber 1" description="Fridge in the garage" Authorization:$AUTH_TOKEN
```

Now you can log temperatures to the project by including the project's id (in this case, 1):

```
http POST :3000/projects/1/temps value=98.6 Authorization:$AUTH_TOKEN
```
