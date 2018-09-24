load("//:nanopb.bzl", "nanopb_proto_library")

nanopb_proto_library(
    name = "simple_proto",
    srcs = ["simple.proto"],
)

cc_binary(
    name = "simple",
    srcs = ["simple.c"],
    deps = [":simple_proto"],
)
