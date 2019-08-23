
if(__add_qbdi_config)
    return()
endif()
set(__add_qbdi_config ON)

# ========================
# QBDI Version
# ========================
set(QBDI_VERSION_MAJOR 0)
set(QBDI_VERSION_MINOR 7)
set(QBDI_VERSION_PATCH 1)
set(QBDI_VERSION_DEV 1)

set(QBDI_VERSION_STRING "${QBDI_VERSION_MAJOR}.${QBDI_VERSION_MINOR}.${QBDI_VERSION_PATCH}")
if (QBDI_VERSION_DEV)
    set(QBDI_VERSION_STRING "${QBDI_VERSION_STRING}-devel")
endif()


# ========================
# QBDI Platform
# ========================
set(QBDI_SUPPORTED_PLATFORMS
    "ANDROID"
    "LINUX"
    "WINDOWS"
    "OSX"
    "IOS")

set(QBDI_SUPPORTED_ARCH
    "ARM"
#    "AARCH64" # not supported yet
    "X86"
    "X86_64"
    )

set(QBDI_PLATFORM_WINDOWS 0)
set(QBDI_PLATFORM_LINUX   0)
set(QBDI_PLATFORM_ANDROID 0)
set(QBDI_PLATFORM_OSX     0)
set(QBDI_PLATFORM_IOS     0)

set(QBDI_ARCH_X86     0)
set(QBDI_ARCH_X86_64  0)
set(QBDI_ARCH_ARM     0)
set(QBDI_ARCH_AARCH64 0)

set(QBDI_BITS_32 0)
set(QBDI_BITS_64 0)

# Check platform
if(NOT DEFINED QBDI_PLATFORM)
    message(FATAL_ERROR "Please set 'QBDI_PLATFORM'\nSupported platform: ${QBDI_SUPPORTED_PLATFORMS}")
elseif (QBDI_PLATFORM STREQUAL "WINDOWS")
    set(QBDI_PLATFORM_WINDOWS 1)
elseif(QBDI_PLATFORM STREQUAL "LINUX")
    set(QBDI_PLATFORM_LINUX 1)
elseif(QBDI_PLATFORM STREQUAL "ANDROID")
    set(QBDI_PLATFORM_ANDROID 1)
elseif(QBDI_PLATFORM STREQUAL "OSX")
    set(QBDI_PLATFORM_OSX 1)
elseif(QBDI_PLATFORM STREQUAL "IOS")
    set(QBDI_PLATFORM_IOS 1)
else()
    message(FATAL_ERROR "${QBDI_PLATFORM} is not a supported platform.\nCurrently supported: ${QBDI_SUPPORTED_PLATFORMS}")
endif()

# Check arch
if (NOT DEFINED QBDI_ARCH)
    message(FATAL_ERROR "Please set 'QBDI_ARCH'\nSupported architecture: ${QBDI_SUPPORTED_ARCH}")
elseif (QBDI_ARCH STREQUAL "ARM")
    set(QBDI_ARCH_ARM 1)
    set(QBDI_BITS_32 1)
    set(QBDI_LLVM_ARCH "ARM")
    set(QBDI_BASE_ARCH "ARM")
#elseif(QBDI_ARCH STREQUAL "AARCH64")
#    set(QBDI_ARCH_AARCH64 1)
#    set(QBDI_BITS_64 1)
#    set(QBDI_LLVM_ARCH "AARCH64")
elseif(QBDI_ARCH STREQUAL "X86")
    set(QBDI_ARCH_X86 1)
    set(QBDI_BITS_32 1)
    set(QBDI_LLVM_ARCH "X86")
    set(QBDI_BASE_ARCH "X86_64")
elseif(QBDI_ARCH STREQUAL "X86_64")
    set(QBDI_ARCH_X86_64 1)
    set(QBDI_BITS_64 1)
    set(QBDI_LLVM_ARCH "X86")
    set(QBDI_BASE_ARCH "X86_64")
else()
    message(FATAL_ERROR "${QBDI_ARCH} is not a supported architecture.\nCurrently supported: ${QBDI_SUPPORTED_ARCH}")
endif()

if(QBDI_PLATFORM_LINUX AND NOT (QBDI_ARCH_X86 OR QBDI_ARCH_X86_64 OR QBDI_ARCH_ARM))
    message(FATAL_ERROR "Linux platform is only supported for X86, X86_64 and ARM architectures.")
endif()

if(QBDI_PLATFORM_WINDOWS AND NOT (QBDI_ARCH_X86 OR QBDI_ARCH_X86_64))
    message(FATAL_ERROR "Windows platform is only supported for X86 and X86_64 architectures.")
endif()

if(QBDI_PLATFORM_OSX AND NOT (QBDI_ARCH_X86 OR QBDI_ARCH_X86_64))
    message(FATAL_ERROR "OSX platform is only supported for X86 and X86_64 architectures.")
endif()

if(QBDI_PLATFORM_IOS AND NOT QBDI_ARCH_ARM)
    message(FATAL_ERROR "IOS platform is only supported for ARM architecture.")
endif()

if(QBDI_PLATFORM_ANDROID AND NOT QBDI_ARCH_ARM)
    message(FATAL_ERROR "Android platform is only supported for ARM architecture.")
endif()

message("\n== QBDI Target ==")
message("QBDI Platform: ${QBDI_PLATFORM}")
message("QBDI ARCH:     ${QBDI_ARCH}")
message("LLVM ARCH:     ${QBDI_LLVM_ARCH}")
message("")

