---
title: 'Dnsmasq: A Reality Check and Remediation Practices'
short: |
    Many vulnerabilities in one shot, yet several pre-conditions for a target to be actually exploitable. Here's simple flowchart to check whether your Dnsmasq deployments are vulnerable.
date: 'October 9, 2017'
tags: [trendmicro, measurement, vulnerability]
---

[Dnsmasq](http://www.thekelleys.org.uk/dnsmasq/doc.html) is the de-facto tool
to implement DNS and DHCP services in small servers and embedded devices. Being
Dnsmasq user, when [Google Security researchers disclosed the CVE-2017-14491 to
14496
series](https://security.googleblog.com/2017/10/behind-masq-yet-more-dns-and-dhcp.html),
I quickly checked whether my installation was vulnerable.

Turned out that, despite I found a vast amount of devices running a vulnerable
version of Dnsmasq, the chain of pre-conditions for these vulnerabilities to be
exploitable are not super trivial. So I decided to write them down in
a flowchart.


You can read [the full blog post here](http://blog.trendmicro.com/trendlabs-security-intelligence/dnsmasq-reality-check-remediation-practices/)!
