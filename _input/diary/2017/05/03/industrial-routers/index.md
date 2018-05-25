---
title: The Role of Industrial Routers in Keeping the Future Factory Secure
short: |
    Industrial routers play a very crucial role: a single vulnerability can
    grant the attacker access to an entire network of critical machines. In
    this research, I've looked at how easy it is for a hypothetical attacker to
    find and enumerate industrial routers, and the security posture of their
    vendors.
date: May 03, 2017
tags: [vulnerability, trendmicro, iiot, routers, industry]
bibliography: _data/publications/publications.bib
csl: _style/csl/publications.csl
---

Industrial routers aren't just regular routers in a rugged case. They are the
gateway to networks of *machines*, which usually end up interacting with the
physical world. Think about connected vehicles, factories, robots, and so on.

While working on a remote access box (another name for "industrial router"),
during our [industrial robots research](http://robosec.org), we noticed that
the web-admin panel had an authentication-bypass vulnerability. Upon reporting
the [vulnerability to the vendor, which patched it right
away](https://websupport.ewon.biz/support/news/support/ewon-security-enhancement-fw-112s2-0),
we've wondered: are there other vendors? What's the state of security in this
area?

After going through the "Switches Get Stitches" talks ([44CON 2014](https://www.slideshare.net/44Con/switches-getstitches), [31C3 2014](https://media.ccc.de/v/31c3_-_6196_-_en_-_saal_1_-_201412281130_-_switches_get_stitches_-_eireann_leverett), [Black Hat US 2015](https://www.youtube.com/watch?v=urjKkQaspHQ)),
we had some bad feelings about industrial routers too, so we've started to
collect technical resources like manuals and firmware update files, and crafted
Shodan and Censys search strings to see how many of these routers were directly
exposed to a casual attacker.

The first thing that we've noticed was the abundance of technical information
freely available to the public. Don't get me wrong: I'm not advocating in favor
of "security through obscurity" nor "closed source". Once I believe in
openness, I also believe that critical targets like industrial routers (which
are put in front of supposedly critical machinery), shouldn't be *that* easy
for a casual attacker to discover. Ironically, marketing brochures required
a registration, whereas firmware and technical manuals were directly indexed by
search engines and publicly accessible.

Given the security posture of some vendors, we've decided to take a broad look
at all of them, both from a reconnaissance and vulnerability viewpoint.

If you're curious, head over to the [full article](https://blog.trendmicro.com/trendlabs-security-intelligence/compromising-industrial-robots/) on TrendLab's Security Intelligence Blog.

### References

[@quarta_robosecbhus_talk_2017]

[@quarta_robosec_2017]
