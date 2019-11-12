Through local debugging capabilities, we can run code in a local simulation environment, send simulation test events, and get the running log of function code and time and memory usage.

## Dependent component

Before running local debugging, make sure that Docker is installed and started in your local environment. The installation and configuration process of Docker can refer to the [installation and configuration](https://cloud.tencent.com/document/product/583/33449) .

## Debug command

The scf cli completes the local trigger run by the `local invoke` subcommand. The scf command line tool will start the container instance according to the specified function template configuration file, mount the code directory to the specified directory of the container instance, and run the code through the specified trigger event to implement the local cloud function simulation run.

### Parameter Description

The parameters supported by the `scf local invoke` command are as follows:

Parameter | Required | Description | Example
--- | --- | --- | ---
event | no | The source of the file for the simulated test event, the file content must be in JSON format | event.json
Template | no | The project describes the path or file name of the configuration file. The default is template.yaml | template.yaml
env-vars | no | The environment variable configuration when the function is running, you need to specify the environment variable configuration file, the content must be in JSON format. | env.json
debug-port | no | The port exposed when the function is running. After the port is specified, the container will start in debug mode and expose the specified port. | 3366
debugger-path | no | The debugger path in this machine. After the path is specified, the container will load the debugger into the container when it runs. | /root/debugger/pydev
debug-args | no | The debugger startup parameters in this machine. After the parameter is specified, the specified parameters will be passed when the debugger starts. | 
docker-volume-basedir | no | Specify the path to mount to the container | /user/xxx/code/project
docker-network | no | Specifies the network used by the container, using bridge mode by default | bridge
log-file | no | Specify output log to file | /user/xxx/code/project/log.txt
skip-pull-image | no | Skip checking and pulling new container images | 

The support option FUNCTION_IDENTIFIER is described as follows:

Parameter | Required | Description | Example
--- | --- | --- | ---
FUNCTION_IDENTIFIER | no | Indicates the identifier and name of the function; if there are multiple function descriptions in the project description configuration file, you can use this parameter to specify the function to be debugged. | hello_world

### Test event

The simulation event used to trigger the cloud function locally can be passed through the command pipeline of linux or passed through a file.

- **Passing through the command pipeline:** The `scf local invoke` command supports receiving events from the command line pipeline. We can generate events and pass them by executing the `scf local generate-event` command to form a debug command such as `scf local generate-event cos post | scf local invoke --template template.yaml`. We can also construct the output JSON format content and pass it to the `scf local invoke` command to form a debug command such as `echo '{"test":"value"}' | scf local invoke --template template.yaml` .
- ** Passing the file: ** Specify the file containing the contents of the test simulation event by using the `--event` parameter of the `scf local invoke` command. The file content must be a JSON data structure, forming a debug command such as `scf local invoke --template template.yaml --event event.json` .

### Use example

The sample project that was initialized by `scf init` has the prepared code file and template configuration file. Take the example project as an example. Suppose a testproject project is created in the /Users/xxx/code/scf directory under the environment Python 2.7.

We pass the simulation event of the cos post file through the command pipeline, triggering the function to run. The function code content only prints the event and returns "hello world". The function code /Users/xxx/code/scf/testproject/hello_world/main.py is as follows:

```python
# -*- coding: utf8 -*-

def main_handler(event, context):
    print(event)
    return "hello world"

```

1. The startup function runs locally by executing the `scf local generate-event cos post | scf local invoke --template template.yaml ` command:

```bash
$ scf local generate-event cos post | scf local invoke --template template.yaml 
read event from stdin
pull image ccr.ccs.tencentyun.com/scfrepo/scfcli:python3.6......
START RequestId: 766e10b0-fd41-42ed-acd4-c161833e3bd2
{'Records': [{'cos': {'cosSchemaVersion': '1.0', 'cosObject': {'url': 'http://testpic-1253970026.cos.ap-guangzhou.myqcloud.com/testfile', 'meta': {'Content-Type': '', 'x-cos-request-id': 'NWMxOWY4MGFfMjViMjU4NjRfMTUyMV8yNzhhZjM='}, 'key': '/1253970026/testpic/testfile', 'vid': '', 'size': 1029}, 'cosBucket': {'region': 'gz', 'name': 'testpic', 'appid': '1253970026'}, 'cosNotificationId': 'unkown'}, 'event': {'eventVersion': '1.0', 'eventTime': 1545205770, 'requestParameters': {'requestSourceIP': '59.37.125.38', 'requestHeaders': {'Authorization': 'q-sign-algorithm=sha1&q-ak=AKIDQm6iUh2NJ6jL41tVUis9KpY5Rgv49zyC&q-sign-time=1545205709;1545215769&q-key-time=1545205709;1545215769&q-header-list=host;x-cos-storage-class&q-url-param-list=&q-signature=098ac7dfe9cf21116f946c4b4c29001c2b449b14'}}, 'eventName': 'cos:ObjectCreated:Post', 'reqid': 179398952, 'eventSource': 'qcs::cos', 'eventQueue': 'qcs:0:lambda:cd:appid/1253970026:default.printevent.$LATEST', 'reservedInfo': ''}}]}
END RequestId: 766e10b0-fd41-42ed-acd4-c161833e3bd2
REPORT RequestId: 766e10b0-fd41-42ed-acd4-c161833e3bd2 Duration: 0 ms Billed Duration: 100 ms Memory Size: 128 MB Max Memory Used: 15 MB
"hello world"
```

As you can see from the output, after the function finishes running, it outputs the print log of the function and the function return content.

1. Generate the following event.json test event file:

```json
{
"key1":"value1",
"key2":"value2"
}
```

1. By executing the `scf local invoke --template template.yaml --event event.json` command, the startup function runs locally and outputs test events via a file:

```bash
$ scf local invoke --template template.yaml --event event.json 
pull image ccr.ccs.tencentyun.com/scfrepo/scfcli:python3.6......
START RequestId: 4a06d73d-e716-4e58-bc5f-ecfc955d77bd
{'key1': 'value1', 'key2': 'value2'}
END RequestId: 4a06d73d-e716-4e58-bc5f-ecfc955d77bd
REPORT RequestId: 4a06d73d-e716-4e58-bc5f-ecfc955d77bd Duration: 0 ms Billed Duration: 100 ms Memory Size: 128 MB Max Memory Used: 15 MB
"hello world"
```

As you can see from the output, the function code prints the test event and returns the specified content.
