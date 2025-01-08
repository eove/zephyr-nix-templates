# This file is property of EOVE SAS.

# This defines the minimum version of CMake this config is compliant with.
cmake_minimum_required(VERSION 3.25)

# Load the Zephyr package and search from the zephyr directory.
find_package(Zephyr REQUIRED HINTS "$ENV{ZEPHYR_BASE}")

# Declare the CMake project.
project(app)

# Headers.
#target_include_directories(app PRIVATE include/)

# And its sources.
target_sources(app PRIVATE
  # Entry point
  src/main.c
)
