# Before contributing

## Ryba's packages

Ryba comes with several packages.
[ryba-cluster](http://github.com/ryba-io/ryba.git) is the packages which helps you to deploy a cluster.
You can test ryba immediately if you want by following this link.

[Ryba](http://github.com/ryba-io/ryba.git) which is the package containing all the components deployable by Ryba.
We remind you that a component is seen as a module by Ryba see [this page](/documentation/overview/.

## get `ryba-cluster`

check [this section](/documentation/start/) to download ryba-cluster and get familiar with it.

## Get ryba

Open a prompt and at the same directory level than ryba-cluster install ryba.
you can download and install ryba by typing the commands.

```
git clone https://github.com/ryba-io/ryba.git
cd ryba
npm install
```


## Link Ryba to Ryba-cluster

If you are not familiar with npm:
NPM when running npm install, reads the package.json file and install all the dependecies in the node_modules directory.
That what's happenend when you've down the previous step, you can check the node_modules directory of ryba-cluster !

But for developement environment we can not modify directly this folder because at the next npm install all your modifications will be erased.

To answer this problem npm  has the link functionnality.
So once in ryba-cluster.
Link ryba to ryba-cluster.
```
npm link
cd ../ryba-cluster
npm link ryba
```
Now we are ready to start developping or module
