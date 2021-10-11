add_executable(main main.cpp)
target_link_options(main PRIVATE -static-libgcc -static-libstdc++)
install(TARGETS main RUNTIME DESTINATION bin)
