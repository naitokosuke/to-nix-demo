package main

import (
	"fmt"
	"runtime"
)

func main() {
	fmt.Printf("Hello from Nix-managed Go!\n")
	fmt.Printf("  version: %s\n", runtime.Version())
	fmt.Printf("  os/arch: %s/%s\n", runtime.GOOS, runtime.GOARCH)
}
