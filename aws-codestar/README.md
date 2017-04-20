### Up 'n Running w/Angular 2 on AWS CodeStar

[CodeStar](https://news.ycombinator.com/item?id=14149570) is a service provided by AWS to build and deploy apps more quickly. Read more about it [here](https://aws.amazon.com/codestar/).

In the meantime, let's get more familiar with the tool by deploying a simple Angular 2 application.

#### First things first...

Let's create a simple Angular 2 (ng2) app using the [CLI tool](https://cli.angular.io/):

```
ng new my-codestar-app
```

That should be all you need for a working ng2 app. Prove it via:

```
cd my-codestar-app
ng serve
```

Et voila! Navigate to [http://localhost:4200](http://localhost:4200) and you should see that the **app works!**

#### Now then

Hop onto and create a similar service inside AWS CodeStar. You can mostly follow [these instructions](https://aws.amazon.com/blogs/aws/new-aws-codestar/) that kick off from [this page](https://aws.amazon.com/codestar/).

If you want to follow this guide closely, then just be sure to:

- select a Node.js app running through Amazon's Lambda service
- use the **Command line tools** option to edit the project code
- name the AWS app something like `my-codestar-app`

... Once you've got access to a working instance of the basic Node app (as described in the instructions), then carry on to update those files with out ng2 app.

#### From "Hello World" to "Hello ng2"

So you've:

- setup a CodeStar account
- cloned the Git repository that's hosting the code on AWS
- waited long enough for your app to deploy
- visited the public facing URL to see that all is well and working

Great! Now let's update that `public/` directory with our ng2 code.

Navigate back to your ng2 project and build a `dist/` folder.

```
ng build --prod
```

Once that's complete, the `dist/` folder contains everything that needs to exist inside the CodeStar `public/` folder. Let's copy that on over...

_Note: If you're worried about mistakes here, go ahead and make a backup branch to revert to if failure occurs. (e.g. `git checkout -b backup && git checkout master`)_

```
cd dist
cp -r * /path/to/codestar/clone/my-codestar-app/public
```

Before we call it almost a day, we'll need to update our files in this AWS repo. There's a better way of going about this, but I'm in a hurry and we'll do it manually for now.

- Open `inde!x.html` and update the `<script src="..."` to `<script src="assets/js/..."`
- Move the ng2 JS files to the `assets/js` folder

e.g.

```
cd /path/to/codestar/clone/my-codestar-app/public
mv *.js assets/js
vi index.html
# update the script src attributes to account for new file locations (e.g. src="assets/js/vendor...")
```

Ok. We'll need to fix that process in the future. `todo`

Now we can commit and push our new additions to this AWS repo.

```
cd /path/to/codestar/clone/my-codestar-app/
git add public
git commit -m "init ng2 app"
git push
```

If you navigate to the CodeStar console on AWS, you'll see nothing has been changed/deployed. You'll need to hit that lovely **Release change** button above the pipeline.

![release change](https://github.com/cameronbriar/ng2/blob/master/aws-codestar/assets/release_change.png?raw=true)

Once you do, our new **Source** code will pull in and the build process will begin. Wait for it... et voila! You're **app works!** on AWS using CodeStar & Lambda!

![final result](https://github.com/cameronbriar/ng2/blob/master/aws-codestar/assets/final.png?raw=true)

"Ops" made easy... amiright?

### Coming soon

- how do we add more chains into the pipeline/build process (e.g. Jenkins, hooks, etc.)?
- how do we got about deploying more complicated apps? using Docker?
- spend more than 20 minutes on this document
- etc...

#### Side Notes:

This is pretty awesome. It could be a much simpler approach to CD for many.

The pipeline execution time, as far as I can tell, is pretty slow. This ng2 app is fairly small and the **Deploy** cycle alone took some 5 - 10 minutes.

Trying something new isn't always this easy. Awesome work by the AWS team.
