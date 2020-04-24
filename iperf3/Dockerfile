FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y iperf3
EXPOSE 5201
CMD ["iperf3", "-s"]
