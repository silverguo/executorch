# Copyright (c) Meta Platforms, Inc. and affiliates.
# All rights reserved.
#
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

# Please this file formatted by running:
# ~~~
# cmake-format -i CMakeLists.txt
# ~~~

cmake_minimum_required(VERSION 3.19)

# Source root directory for executorch.
if(NOT EXECUTORCH_ROOT)
  set(EXECUTORCH_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/../..)
endif()

add_library(extension_apple)

file(GLOB EXPORTED_SOURCES
  ExecuTorch/Exported/*.m
  ExecuTorch/Exported/*.mm
)

file(GLOB INTERNAL_SOURCES
  ExecuTorch/Internal/*.m
  ExecuTorch/Internal/*.mm
)

target_sources(extension_apple PRIVATE
  ${EXPORTED_SOURCES}
  ${INTERNAL_SOURCES}
)

target_include_directories(extension_apple
  PUBLIC ExecuTorch/Exported
  PRIVATE ExecuTorch/Internal
)

find_library(FOUNDATION_FRAMEWORK Foundation)
target_link_libraries(extension_apple
  PRIVATE executorch ${FOUNDATION_FRAMEWORK}
)

target_compile_options(extension_apple PUBLIC ${_common_compile_options})
target_compile_options(extension_apple PRIVATE
  "-fobjc-arc"
  "-fno-exceptions"
  "-fno-rtti"
)
