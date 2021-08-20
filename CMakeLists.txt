cmake_minimum_required(VERSION 3.16)

project(structmodel CXX C)

if (NOT ${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
  message(FATAL_ERROR "Do not support non-Linux now!")
endif()

# TODO: remove it in the future
# set(CMAKE_BUILD_TYPE Debug CACHE STRING "Set build type to DEBUG" FORCE)
# message(AUTHOR_WARNING "Overwrite build type to DEBUG for development")

# # output path
# set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
# set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
# set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# third party
set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake;${CMAKE_MODULE_PATH}")

find_package(BAGUA REQUIRED)

# if (Dyninst_FOUND) 
#   message(STATUS "Found Dyninst: " ${DYNINST_INCLUDE_DIR})
# endif()

option(ENABLE_TEST "Enable test" ON)
option(ENABLE_EXAMPLE "Enable example" ON)
option(ENABLE_SANITIZE "Enable sanitize" OFF)

# explicitly list all source file

add_executable(binary_analyzer src/perf/binary_analyzer.cpp)



set_target_properties(
  binary_analyzer

  PROPERTIES
  ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
  LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
  RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
)



set_property(TARGET binary_analyzer PROPERTY CXX_STANDARD 17)
set_property(TARGET binary_analyzer PROPERTY CXX_STANDARD_REQUIRED ON)
if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  if(CMAKE_CXX_COMPILER_VERSION VERSION_LESS "7.0.0")
    message(FATAL_ERROR "Insufficient GCC version (${CMAKE_CXX_COMPILER_VERSION}), need > 7.0.0")
  endif()
else()
  message(FATAL_ERROR "Do not support cxx compiler for ${CMAKE_CXX_COMPILER_ID}, choose GNU please")
endif()


# FIXME: how to use sanitize for subproject?
# if (ENABLE_SANITIZE) 
#   target_compile_options(
#     binary_analyzer PUBLIC
#     $<$<CONFIG:DEBUG>:-fsanitize=address -g>
#   )
# endif()

target_include_directories(binary_analyzer PRIVATE ${BAGUA_INCLUDE_DIRS})

# if(OpenMP_CXX_FOUND)
#     target_link_libraries(baguatool PUBLIC OpenMP::OpenMP_CXX)
# endif()

target_link_libraries(binary_analyzer PRIVATE baguatool)



# if (ENABLE_EXAMPLE)
#   add_subdirectory(${PROJECT_SOURCE_DIR}/example/simple)
#   add_subdirectory(${PROJECT_SOURCE_DIR}/example/project/graph_perf)
# endif()

# if (ENABLE_TEST)
#   # List what we want to test
#   add_subdirectory(${PROJECT_SOURCE_DIR}/test/igraph_test)
# endif()

# install(TARGETS baguatool DESTINATION lib)
