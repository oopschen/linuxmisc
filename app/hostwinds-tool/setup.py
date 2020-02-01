#!/usr/bin/env python

from setuptools import setup, find_packages
setup(
    name = "hostwinds-tool",
    version = "1.0.0",
    packages = find_packages('src'),
    package_dir = {"": 'src'},
    entry_points = {
      "console_scripts": [
        "hw-alert=hostwinds.entry.alert_command:main"
        ]
      },
    install_requires=["requests"],
    author="oopsc",
    author_email="linxray@gmail.com",
    keywords="hostwinds api, alert",
    url="https://github.com/oopschen/linuxmisc/app/hostwind-tool",
    description="a simple tool for hostwinds api, support alert bandwidht usage",
    license="MIT"

)
