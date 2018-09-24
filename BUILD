licenses(["notice"])

exports_files(["LICENSE.txt"])

load("@com_google_protobuf//:protobuf.bzl", "py_proto_library")
load("//:nanopb.bzl", "nanopb_proto_library")

package(default_visibility = ["//visibility:public"])

cc_library(
  name = "nanopb",
  visibility = ["//visibility:public"],
  includes = ["./srcs"],
  hdrs = [
    "srcs/pb.h",
    "srcs/pb_common.h",
    "srcs/pb_decode.h",
    "srcs/pb_encode.h",
  ],
  srcs = [
    "srcs/pb_common.c",
    "srcs/pb_decode.c",
    "srcs/pb_encode.c",
  ],
)

py_binary(
    name = "nanopb_generator",
    args = [
        "--protoc-plugin",
    ],
    srcs = [
        "generator/nanopb_generator.py",
    ],
    deps = [
      ":nanopb_py_proto",
      ":plugin_py_proto",
      "@com_google_protobuf//:protobuf_python",
    ],
)

py_proto_library(
    name = "nanopb_py_proto",
    srcs = ["generator/proto/nanopb.proto",
    ],
    deps = [":descriptor_py_proto"],
    include = "generator/proto",
)

py_proto_library(
    name = "plugin_py_proto",
    srcs = ["generator/proto/plugin.proto",],
    deps = [":descriptor_py_proto"],
    include = "generator/proto",
)

py_proto_library(
    name = "descriptor_py_proto",
    srcs = ["generator/proto/google/protobuf/descriptor.proto",
    ],
    include = "generator/proto",
)

nanopb_proto_library(
    name = "nanopb_proto",
    srcs = ["generator/proto/google/protobuf/descriptor.proto", "generator/proto/nanopb.proto"],
    deps = [],
    includes = ["generator/proto"],
    add_nanopb_deps = False,
    generate_cc_srcs = False,
)

