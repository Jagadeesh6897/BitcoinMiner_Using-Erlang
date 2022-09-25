# COP5615 - Distributed Operating System Principles - Project 1
# Bitcoin Miner using Erlang

The objective of this project is to create, multi-core-compatible solution to the bitcoin mining problem using Erlang and the actor model.
## Group Members:

- Jagadeeshwar Reddy Baddam (UFID: 99510882)
- Yeshitha Linga (UFID: 37260022)


## Implementation

First we started implementing it on single node and generated strings and then moved it to bigger scale where master node generates strings with the help of workers (multiple actors) and any other client can join the coin mining and generate strings on server side. 

All actors are intended to spawn in a single machine for linear parallelism but for distributed parallelism we run spawns in multiple devices where they interact with master and print the hashed strings in order.

## How to execute code in Intellij terminal

1.	For linear parallelism we could just run the single server.erl file and get the hashed coins or mined coins .

2.	But, for distributed parallelism  the steps are listed below.

•	Run the server on server system using server.erl

•	Then run the client using client.erl and request for connection to server

•	When the connection is established the client starts mining on it’s machine 

•	When client gets the mined coins, it sends the coins to server and prints on the server side stating “From client”.
## Size of work unit

The work unit of our program is in range of 1000000 and 100000000. There is no limit for the number of coins to be mined. So, After the above mentioned threshold the worker units take longer than usual time and In general the total number of actors used is 2* the number of processors.
## Sample result

The following hashed strings were generated as a result of distributed parallelism between the master and workers for the input - 4

```bash
(jag@Jag)1> c(server).
{ok,server}
(jag@Jag)2> server:start(4).
<0.100.0>
(jag@Jag)3> server random_String: "jbaddamaf4pvh3zzfe78nrl", Zeroes for Hashin is  4,  and Hashed Data is:  "0000ce9c317501919ec0d5f08b2b74aa1fec496fb69ad8af83e7
e718d1596f2b"
(jag@Jag)3> server random_String: "jbaddamptzf3qbd339k8cy7", Zeroes for Hashin is  4,  and Hashed Data is:  "00007e777f698cb26873494d5ed9ee0656e9b8c1de9def22adee
b7e925286abc"
(jag@Jag)3> client connection established and started mining for <13309.103.0>
(jag@Jag)3> "yeshil" random_String: "yeshilwxm3v36k6ynqo5qm", Zeroes for Hashing is  4   Hashed Data is:  "0000ed30c651718a97eb5e6584aba4e950eedbe0afbc4de4eec96e
1f8daea318"
(jag@Jag)3> "yeshil" random_String: "yeshilpn003jvrn7tjv9wt", Zeroes for Hashing is  4   Hashed Data is:  "000072ce48a84fae5f6e574cd1131a7acce2c7fb9b6398847d56f8
b8422dfafb"
(jag@Jag)3> server random_String: "jbaddam0jj6l083bywea5zs", Zeroes for Hashin is  4,  and Hashed Data is:  "0000b4681dc2069b27092c3cfe4344d146e148436cc3da821daa
d8890a02dc98"
(jag@Jag)3> "yeshil" random_String: "yeshilia5rka3irbh5ntaz", Zeroes for Hashing is  4   Hashed Data is:  "00009ac9468d09ef6a008b235f2729296bc8e724c63d1b3e7fab60
d9eca5129f"
(jag@Jag)3> "jagan" random_String: "jaganqv8v3tzjvp4w9j2z", Zeroes for Hashing is  4   Hashed Data is:  "000050849d52f4351c1b9bfcf87d160c58ca0cea2c43c2bceab5201f
26d13522"
```

## Running time

To calculate the resource utilization, statistics(runtime) and statistics(wallclock_time) are used.

```bash
CPU time  :  24672 ms
Real time :  6147 ms
Ratio : 4.013 
```

## Coin with most zeros

The following hashed strings were created for the most number of zeros - 7

```bash
(yeshi@Yeshi)4> server:start(7).
client connection established and started mining for <8809.96.0>
the string is "yeshidjq2x3578bj1rgdiwxeoya1e0fjjqs7l"   and hashed string is  "0000000f1f9f22f43f95e835bc72fc4f34b26a06b9f86e1020c0abbe2e46645b"
the string is "yeshi6bo6lti3rzlved47zpaskbjn5lgn37q6"   and hashed string is  "000000076734b7befd557adc6a3390afac9cc25fec8a89bb598aeff2ccd22be5"
the string is "yeship97o16x5w8jgn5wcy0v99045igk5vh4l"   and hashed string is  "0000000a510af32b3e18f163f7c688c401074e57f68fd2332df85f2d607391b3"
the string is "yeship6c6np7sh45hrdj3sav0hlyvgcwb26pw"   and hashed string is  "0000000d55a161b571eb173bed9e11c49e16f924b007cf558d26b5ad88b2d66c"
the string is "yeshi764cnoyezjkse7vlm141j9puged15iip"   and hashed string is  "0000000538900c7e187c0e5bcc026aac6f9690dbdc98672a45d4cb1113a706f4"
```

## Largest number of working machines on which the code was run

The code was parallely executed on 5 machines(one i7 deca-core,one apple m2, one i5 quadcore, one ryzen 5 hexacore, one ryzen 7 hexacore) with 4 workers and 1 master.
