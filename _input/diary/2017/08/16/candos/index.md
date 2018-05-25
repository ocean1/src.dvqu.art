---
title: From a Bit-flipping to a Vulnerability in the CAN Standard
short: |
    CAN-based protocols are vulnerable to bit-flipping attacks at the link layer. In this collaborative research, Politecnico di Milano's [NECSTLab](https://necst.it) and Trend Micro's FTR analyze the protocol in depth and demonstrate the vulnerability on a real car, with PoC and so on.

date: August 16, 2017
tags: [cars, vulnerability, trendmicro, polimi, dimva17, paper]
bibliography: _data/publications/publications.bib
csl: _style/csl/publications.csl
---

This project started somewhere between 2015 and 2016. Back then, I was an
Assistant Professor at Politecnico di Milano. Together with my colleague
[Stefano](https://twitter.com/raistolo), I was advising this bright Master
student, [Andrea Palanca](https://www.linkedin.com/in/andreapalanca/), who was
basically "breathing cars," and really passionate about car hacking. So it made
a lot of sense to introduce him to [Eric Evencick](http://www.evenchick.com/),
who then became part of the project.

Eric had this idea of looking at the link layer of the CAN protocol, given the
numerous frame-injection attacks popping up here and there. However, we've
thought, injecting frame in the CAN bus is pretty noisy, and also quite easy to
detect with some smart monitoring. Indeed, knowing the network architecture and
ECUs attached to it (and, let's be honest, they don't change that often even in
a connected car), it's fairly easy to figure out if a frame is out of order, or
simply unexpected.

Andrea then started to dig into the CAN bus standard, using his own car as
a playground, and quickly came up with a prototype testbed CAN deployment in
the lab, on which he started to explore the effect of flipping "the right bit
at the right time".

Alright, enough high-level talking! It's time to take a look at the actual
content.

### Gimme da Video!
In the following short video you can see me presenting the work to an academic
audience. True fact: I've recorded this while preparing my talk for [DIMVA
2017](https://itsec.cs.uni-bonn.de/dimva2017/).

<div class="videoWrapper"><iframe src="https://www.youtube-nocookie.com/embed/oajtDFw_t3Q" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe></div>

### Additional Material
If you're curious to know more:

* for an intermediate-level description, you can read our [blog post](https://blog.trendmicro.com/trendlabs-security-intelligence/connected-car-hack/),
* for a more in-depth piece, head over to the [technical brief (PDF)](https://documents.trendmicro.com/assets/A-Vulnerability-in-Modern-Automotive-Standards-and-How-We-Exploited-It.pdf),
* if you're using CAN in your products, you might be interested in our [disclosure through the ICS-CERT (ICS-ALERT-17-209-01)](https://ics-cert.us-cert.gov/alerts/ICS-ALERT-17-209-01).

### References

[@palanca_candos_2017]
