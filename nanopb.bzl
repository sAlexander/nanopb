load("@com_google_protobuf//:protobuf.bzl", "proto_gen") 

def _CcHdrs(srcs):
  return [s[:-len(".proto")] + ".pb.h" for s in srcs]

def _CcSrcs(srcs):
  return [s[:-len(".proto")] + ".pb.c" for s in srcs]

def nanopb_proto_library(name, srcs, deps = [], includes = [], add_nanopb_deps=True, generate_cc_srcs=True):
  lib_hdrs = _CcHdrs(srcs)
  lib_srcs = []
  if generate_cc_srcs:
    lib_srcs += _CcSrcs(srcs)

  gen_deps = []
  if add_nanopb_deps:
    gen_deps += ["//:nanopb_proto"]
  proto_gen(
      name = "%s_genproto" % name,
      srcs = srcs,
      deps=[s + "_genproto" for s in deps + gen_deps],
      includes = includes,
      protoc = "@com_google_protobuf//:protoc",
      plugin = "//:nanopb_generator",
      plugin_language = "nanopb",
      plugin_options = [],
      outs = lib_hdrs + lib_srcs,
  )

  native.cc_library(
      name = name,
      srcs = lib_srcs,
      hdrs = lib_hdrs,
      deps = deps + ["//:nanopb"],
  )

