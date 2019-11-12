# scf cli

------

## Introduction of scf cli

scf cli is a command-line tool for SCF (Serverless Cloud Function). With scf cli, you can easily create, package and deploy your serverless project in minutes. scf can manage functions and events base on a configuration file named `template.yaml`.

scf cli is an open-source project, you are welcomed to feedback by replying to [issues on Github](https://github.com/tencentyun/scfcli/issues).

## Features

* Supports Node.js, Python, Go, PHP
* Manages the lifecycle of your serverless project. (init, package, deploy, update).
* Invoke and debug your serverless project locally. 
* Generation trigger events like  COS, CMQ, Ckafka, and API Gateway to invoke functions locally.
* Validation of TCSAM configuration.

## Quick Start

### Prerequisites

Before installation of scf cli, please make sure the following softwares are already installed.

* Python 2.7+ or Python 3.6+
* pip
* git
* programming language you want to use (such as Node.js 8.9)


#### Install scf cli via pip

Install scf by running  `pip install scf`

```bash
$ pip install scf
```

Verify that the scf cli installed correctly by running `scf --version`.

```bash
$ scf --version
scf CLI, version 0.1.0
```

### Configuring the scf cli

For general use, the scf configure command is the fastest way to set up your scf cli.

You can get in [Tencent Cloud Console](https://console.cloud.tencent.com/developer), then get SecretId and SecretKey in [CAM Console](https://console.cloud.tencent.com/cam/capi).

```bash
$ scf configure set --region ap-guangzhou --appid 1253970223 --secret-id AKIxxxxxxxxxx --secret-key uxxlxxxxxxxx
```

### Init a Project

Create a new project named `testscf` with runtime Node.js 8.9 by running the following command.

```bash
$ scf init --runtime nodejs8.9 --name testscf
```


### Native Invoke 

Change into the newly created directory by running  `$ cd testscf`

Invokes a Serverless Cloud Function without event. 

```bash
$ scf native invoke -t template.yaml --no-event
```

Note: Native invoke only support Node.js runtime by now. And you need to upgrade scf cli version >= 0.2.0 . 

### Package the Project

By running command  `ls` , you can see the project included README, hello\_world function directory and template.yaml. 

Use this command when you want to package your project into a zip file.

```
$ scf package --template-file template.yaml
```
By running command  `ls` again, you can see the project updated with  `deploy.yaml` file and a zip file named like  `32b29935-1ec1-11e9-be82-9801a7af1801.zip` 

### Deploy the Project

Use this command when you have made changes to your functions, events in template.yaml or you simply want to deploy your project.

```bash
$ scf deploy --template-file deploy.yaml 
```

After that, you can go to [SCF Console](https://console.cloud.tencent.com/scf) to check whether the function is successfully deployed.