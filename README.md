# Test Doubles / Simple Stubs

Hey there! We're [thoughtbot](https://thoughtbot.com), a design and
development consultancy that brings your digital product ideas to life.
We also love to share what we learn.

This coding exercise comes from [Upcase](https://thoughtbot.com/upcase),
the online learning platform we run. It's part of the
[Test Doubles](https://thoughtbot.com/upcase/test-doubles) course and is just one small sample of all
the great material available on Upcase, so be sure to visit and check out the rest.

## Exercise Intro

When testing one object, you may find that the other objects it interacts with get in the way. For example, when testing a controller, it can be cumbersome to ensure the model is used correctly:

``` ruby
describe PostsController do
  describe "#index" do
    it "finds the 10 latest published posts" do
      10.times { |i| create(:post, :published, title: "published#{i}") }
      create(:post, published: false, title: "unpublished")

      get :index

      expect(assigns[:posts].map(&:title)).to match_array(%w(
        published0 published1 published2 published3 published4 published5
        published6 published7 published8 published9
      ))
    end
  end
end
```

In this example, the setup and verification phases become complex and hard to follow because we need to re-test the logic to find 10 published posts, even though this logic is already implemented and tested in the model layer.

We can use stubs to clean it up:

``` ruby
describe PostsController do
  describe "#index" do
    it "finds the 10 latest published posts" do
      posts = double("latest_published")
      allow(Post).to receive(:latest_published).and_return(posts)

      get :index

      expect(assigns[:posts]).to eq(posts)
    end
  end
end
```

The `posts` variable above is called a "stub," which is a kind of "test double."

You can create test doubles in RSpec by using the `double` method:

``` ruby
posts = double("latest_published")
```

This creates an object that stands in for an actual list of published posts; it's like a stunt double for your actual object. Using the `double` method is very similar to calling `Object.new`, but tests that use doubles will fail with much clearer error messages. The `"latest_published"` string above is simply a name which will be used in test failure messages.

You can stub out a method on any object (including a test double) by using `allow`:

``` ruby
allow(Post).to receive(:latest_published).and_return(posts)
```

This changes the `Post` class to return `posts` whenever `latest_published` is called. Stubbed methods will revert to their regular behavior after each test runs.

Using the `double` and `allow` methods, you can create simple stubs.

In this exercise, you'll use simple stubs to clean up some tests.

If you'd like to see a quick intro to test doubles, check out the related episode of [the Weekly Iteration](https://upcase.com/videos/stubs-mocks-spies-and-fakes).

## Instructions

To start, you'll want to clone and run the setup script for the repo

    git clone git@github.com:thoughtbot-upcase-exercises/simple-stubs.git
    cd simple-stubs
    bin/setup

After running `bin/setup`, edit `spec/dashboard_spec.rb` and look for test logic which is duplicated from `spec/post_spec.rb`. Use `double` and `allow` to create a stub for posts and eliminate this duplication.

## Tips and Tricks

Useful links:

- Check out our Weekly Iteration episode on [Stubs, Mocks, Spies, and Fakes](https://upcase.com/videos/stubs-mocks-spies-and-fakes) (specifically the first few minutes on `double` and method stubbing).
- Check out the rspec-mocks guides to [test-doubles](https://github.com/rspec/rspec-mocks#test-doubles) and [method stubs](https://github.com/rspec/rspec-mocks#method-stubs)

## Featured Solution

Check out the [featured solution branch](https://github.com/thoughtbot-upcase-exercises/simple-stubs/compare/featured-solution#toc) to
see the approach we recommend for this exercise.

## Forum Discussion

If you find yourself stuck, be sure to check out the associated
[Upcase Forum discussion](https://forum.upcase.com/t/test-doubles-simple-stubs/4609)
for this exercise to see what other folks have said.

## Next Steps

When you've finished the exercise, head on back to the
[Test Doubles](https://thoughtbot.com/upcase/test-doubles) course to find the next exercise,
or explore any of the other great content on
[Upcase](https://thoughtbot.com/upcase).

## License

simple-stubs is Copyright © 2015-2018 thoughtbot, inc. It is free software,
and may be redistributed under the terms specified in the
[LICENSE](/LICENSE.md) file.

## Credits

![thoughtbot](https://presskit.thoughtbot.com/assets/images/logo.svg)

This exercise is maintained and funded by
[thoughtbot, inc](http://thoughtbot.com/community).

The names and logos for Upcase and thoughtbot are registered trademarks of
thoughtbot, inc.
