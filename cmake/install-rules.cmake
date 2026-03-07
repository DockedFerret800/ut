# Project is configured with no languages, so tell GNUInstallDirs the lib dir
set(CMAKE_INSTALL_LIBDIR lib CACHE PATH "")

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

# find_package(<package>) call for consumers to find this project
set(package ${PROJECT_NAME})

install(
    DIRECTORY include/
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
    COMPONENT ${PROJECT_NAME}_Development
)

if(UT_ENABLE_MODULES)
  install(
      TARGETS ${PROJECT_NAME}_${PROJECT_NAME}
      EXPORT ${PROJECT_NAME}Targets
      FILE_SET modules DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
      CXX_MODULES_BMI DESTINATION "" # BMIs are not portable; suppress installation
      COMPONENT ${PROJECT_NAME}_Development
  )
else()
  install(
      TARGETS ${PROJECT_NAME}_${PROJECT_NAME}
      EXPORT ${PROJECT_NAME}Targets
      COMPONENT ${PROJECT_NAME}_Development
  )
endif()

write_basic_package_version_file(
    "${package}ConfigVersion.cmake"
    COMPATIBILITY SameMajorVersion
    ARCH_INDEPENDENT
)

# Allow package maintainers to freely override the path for the configs
set(
    zb8_INSTALL_CMAKEDIR "${CMAKE_INSTALL_DATADIR}/${package}"
    CACHE PATH "CMake package config location relative to the install prefix"
)
mark_as_advanced(${PROJECT_NAME}_INSTALL_CMAKEDIR)

install(
    FILES cmake/install-config.cmake
    DESTINATION "${zb8_INSTALL_CMAKEDIR}"
    RENAME "${package}Config.cmake"
    COMPONENT ${PROJECT_NAME}_Development
)

install(
    FILES "${PROJECT_BINARY_DIR}/${package}ConfigVersion.cmake"
    DESTINATION "${zb8_INSTALL_CMAKEDIR}"
    COMPONENT ${PROJECT_NAME}_Development
)

install(
    EXPORT ${PROJECT_NAME}Targets
    NAMESPACE ${PROJECT_NAME}::
    DESTINATION "${zb8_INSTALL_CMAKEDIR}"
    CXX_MODULES_DIRECTORY modules
    COMPONENT ${PROJECT_NAME}_Development
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
