load("@fbsource//xplat/executorch/build:runtime_wrapper.bzl", "get_aten_mode_options", "runtime")

def define_common_targets():
    """Defines targets that should be shared between fbcode and xplat.

    The directory containing this targets.bzl file should also contain both
    TARGETS and BUCK files that call this function.
    """

    for aten_mode in get_aten_mode_options():
        aten_suffix = "_aten" if aten_mode else ""

        # if aten_mode:
        #     kernel_deps = [
        #         "//executorch/kernels/aten:generated_lib",
        #         "//executorch/kernels/aten:generated_lib_headers",
        #         "//executorch/kernels/test:function_header_wrapper_aten",
        #     ]
        # else:
        #     kernel_deps = [
        #         "//executorch/kernels/portable/cpu:op_add",
        #         "//executorch/kernels/portable/cpu:op_mul",
        #         "//executorch/kernels/portable/cpu:op_clone",
        #         "//executorch/kernels/portable:generated_lib_headers",
        #     ]

        runtime.cxx_library(
            name = "sgd" + aten_suffix,
            srcs = [
                "sgd.cpp",
            ],
            exported_headers = [
                "sgd.h",
            ],
            exported_deps = [
                "//executorch/runtime/core:core",
                "//executorch/runtime/core/exec_aten:lib" + aten_suffix,
            ],  # + kernel_deps,
            visibility = [
                "@EXECUTORCH_CLIENTS",
            ],
        )
