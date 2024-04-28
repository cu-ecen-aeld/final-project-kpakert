SUMMARY = "CircuitPython library for PM2.5 Air Quality Sensors"
HOMEPAGE = "https://github.com/adafruit/Adafruit_CircuitPython_PM25"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=b6ce2897eef74e5da58ccc5ee8319c10"

SRC_URI = "git://github.com/adafruit/Adafruit_CircuitPython_PM25.git;branch=main;protocol=https"
SRCREV = "c06f5fff5bee06bc7b35ed452a069c7e3879ffb2"
SRC_URI[sha256sum] = "9885acb7ac6468ff43a03eaa1df5003797b4063d6e1869296f0b0429bdb8f1a8"

S = "${WORKDIR}/git"

inherit pypi python_setuptools_build_meta

DEPENDS += "python3-setuptools-scm-native"

RDEPENDS:${PN} += " \
    python3-adafruit-blinka \
    python3-adafruit-circuitpython-busdevice \
"


COMPATIBLE_HOST:libc-musl:class-target = "null"
