# zombies

> Terminates your zombie EC2 Instances that are just sucking the money out of your wallet

![Zombie Terminator](http://screencrush.com/442/files/2015/06/the-walking-dead-season-5b3.jpg)

The use case for this tool is actually to clean up old EC2 Test nodes that might have been forgotten about

For example, all my test nodes get brought up with a security group called `ci` and sometimes they don't
get deleted.  _I blame Test Kitchen, but it's really just me forgetting to say kitchen destroy_

anyways, add the following to your `.bash_profile` 

```bash
export AWS_ACCESS_KEY_ID="you aws access key id"
export AWS_ACCESS_KEY_ID="you aws secret access key"

# optional
export AWS_TESTING_SECURITY_GROUP="ci"
```

then terminate your zombies!

```
$ zombies ci
Searching for Instances in the 'ci' security group
Discovered 11 Test Instances.
 1. i-xxxxxxxx : cookbook-default-ubuntu-1404 : running
 2. i-xxxxxxxx : travis-my-cookbook-cloud-ubuntu-1404 : running
 3. i-xxxxxxxx : travis-my-cookbook-cloud-ubuntu-1404 : running
 4. i-xxxxxxxx : test-kitchen-mesos-ubuntu-1404 : running
 
Instance i-xxxxxxxx (cookbook-default-ubuntu-1404) is running.
Would you like to terminate it? [yN]n
Ok, Won't Terminate Instance i-xxxxxxxx
```


# Disclaimer

This tool is dangerous if used improperly... It has the capability to destroy all your EC2 Instances if 
not configured and used correctly.  See [LICENSE.md](LICENSE.md) where it says that this tool is provided
without warranty and you release all it's contributors of liability if you use it.

Ok not fun stuff said : )

# Contact / Contributing

This is Open Source Software, if you want to make this tool better please submitt PRs :heart:




