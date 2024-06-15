#!/bin/sh

export SHERPA_NCNN_CMAKE_ARGS=" -DNCNN_SYSTEM_GLSLANG=ON -DNCNN_VULKAN=ON "
python3 setup.py bdist_wheel
