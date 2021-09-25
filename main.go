package main

import (
	"fmt"
	spike "github.com/spike-events/spike-events"
	"os"
	"os/signal"
	"syscall"
)

func main() {
	connected, err := spike.NewServer(fmt.Sprintf(":%v", 5672))
	if err != nil {
		panic(err)
	}
	<-connected

	sigs := make(chan os.Signal, 1)
	signal.Notify(sigs, syscall.SIGINT, syscall.SIGTERM)

	<-sigs
}
