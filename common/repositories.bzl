# This file has been generated using `bazel run scripts:pinned_browsers`

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("//common/private:dmg_archive.bzl", "dmg_archive")
load("//common/private:drivers.bzl", "local_drivers")
load("//common/private:pkg_archive.bzl", "pkg_archive")

def pin_browsers():
    local_drivers()

    http_archive(
        name = "linux_firefox",
        url = "https://ftp.mozilla.org/pub/firefox/releases/113.0.2/linux-x86_64/en-US/firefox-113.0.2.tar.bz2",
        sha256 = "5a4b4fc537d5d358c0fe416fff91692bae9b62264dabd557cf99fb6cbda91acf",
        build_file_content = """
filegroup(
    name = "files",
    srcs = glob(["**/*"]),
    visibility = ["//visibility:public"],
)

exports_files(
    ["firefox/firefox"],
)
""",
    )

    dmg_archive(
        name = "mac_firefox",
        url = "https://ftp.mozilla.org/pub/firefox/releases/113.0.2/mac/en-US/Firefox%20113.0.2.dmg",
        sha256 = "48749d747b6814e90f643d401a6edf65807551902c8f2fba11de89dc728fa824",
        build_file_content = "exports_files([\"Firefox.app\"])",
    )

    http_archive(
        name = "linux_geckodriver",
        url = "https://github.com/mozilla/geckodriver/releases/download/v0.33.0/geckodriver-v0.33.0-linux64.tar.gz",
        sha256 = "5f5e89bb31fe5f55f963f56ef7e55a5c8e9dc415d94b1ddc539171a327b8e6c4",
        build_file_content = "exports_files([\"geckodriver\"])",
    )

    http_archive(
        name = "mac_geckodriver",
        url = "https://github.com/mozilla/geckodriver/releases/download/v0.33.0/geckodriver-v0.33.0-macos.tar.gz",
        sha256 = "a39c72553beae18c58a560c84cfe86c1708d101bb3d57b8744e3eca64f403703",
        build_file_content = "exports_files([\"geckodriver\"])",
    )

    pkg_archive(
        name = "mac_edge",
        url = "https://msedge.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/5a7ac9fb-6410-4438-a5d1-24a16ab24157/MicrosoftEdge-113.0.1774.57.pkg",
        sha256 = "08a84d425db829e378b558dcc0a3df41a60aa7b25ca999d8afd5ebb3c86382e5",
        move = {
            "MicrosoftEdge-113.0.1774.57.pkg/Payload/Microsoft Edge.app": "Edge.app",
        },
        build_file_content = "exports_files([\"Edge.app\"])",
    )

    http_archive(
        name = "linux_edgedriver",
        url = "https://msedgedriver.azureedge.net/113.0.1774.57/edgedriver_linux64.zip",
        sha256 = "d6992f54c711c1042256b2ab10a0b1054e30222e01484fc068857bee72329adb",
        build_file_content = "exports_files([\"msedgedriver\"])",
    )

    http_archive(
        name = "mac_edgedriver",
        url = "https://msedgedriver.azureedge.net/113.0.1774.57/edgedriver_mac64.zip",
        sha256 = "299b53816807c70498020d05fe18e442627a40a0f987df87702b3089eb93d6af",
        build_file_content = "exports_files([\"msedgedriver\"])",
    )

    http_archive(
        name = "linux_chrome",
        url = "https://storage.googleapis.com/chromium-browser-snapshots/Linux_x64/1121435/chrome-linux.zip",
        sha256 = "10b4f9e1d4c5d3985b2127a8d771f6f9aacb2b49a2104bd72e0627ffe713718d",
        build_file_content = """
filegroup(
    name = "files",
    srcs = glob(["**/*"]),
    visibility = ["//visibility:public"],
)

exports_files(
    ["chrome-linux/chrome"],
)
""",
    )

    http_archive(
        name = "mac_chrome",
        url = "https://storage.googleapis.com/chromium-browser-snapshots/Mac/1121435/chrome-mac.zip",
        sha256 = "472db714979bf7148a629a13f2c561a919c29c129dfbd697824bba9ea8429042",
        strip_prefix = "chrome-mac",
        build_file_content = "exports_files([\"Chromium.app\"])",
    )

    http_archive(
        name = "linux_chromedriver",
        url = "https://chromedriver.storage.googleapis.com/113.0.5672.63/chromedriver_linux64.zip",
        sha256 = "126151e17b5e42a39d6945f1df2b675d08ad2c79b469a84ecca3aa32f9b9a127",
        build_file_content = "exports_files([\"chromedriver\"])",
    )

    http_archive(
        name = "mac_chromedriver",
        url = "https://chromedriver.storage.googleapis.com/113.0.5672.63/chromedriver_mac64.zip",
        sha256 = "26c6be21536fe91e8972b5ddf1e8fccee6f07792f74270c599d0457a663d6dc1",
        build_file_content = "exports_files([\"chromedriver\"])",
    )
