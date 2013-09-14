# Kafka

## What is it?
Kafka is a distributed publish-subscribe system for processing large amounts of streaming data. A single Kafka broker can handle hundreds of megabytes of reads and writes per second from thousands of clients. It's **scalable**, **durable**, **distributed by design** and **totaly awesome**.

## Setup
The script installs by default the latest kafka release, and running on Scala 2.9.2 (as opposed to the 2.8.0 by default). I haven't tested it with newer versions of Scala, so it might break. Feel free to report if you have experiences.

The default configuration installs it as a single broker setup running on localhost, under process supervision by supervisord.

To set it up on/as a cluster, you do need to adapt it, but it should be pretty easy starting from here.
