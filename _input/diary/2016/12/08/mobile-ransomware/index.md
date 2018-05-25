---
title: Mobile (Android) Ransomware
date: December 08, 2016
tags: [android, mobile, ransomware, bheu16, trendmicro]
short: |
    I've started this project while advising a Master student who was
    interested in machine learning. As I've been using machine learning since
    around 2006, I was immediately hooked by the idea of using it to determine
    whether an Android app was trying to lock the target device as part of
    a ransomware scheme.
bibliography: _data/publications/publications.bib
csl: _style/csl/publications.csl
---

There are three core characteristics that are unavoidable for any ransomware
scheme, which can be all boiled down to the "business" need of "being noisy"
and evident. It's true right? For the first time we see malware that is no
longer trying to hide. Instead, it needs to loudly announce its presence to the
victim, in order for the business model to work. If the victim is not aware of
what is happening and is not effectively guided to the payment screen, the
infection is useless.

Therefore, any ransomware needs to:

1. encrypt or lock access to important data,
2. announce its presence to the user and,
3. guide them through the payment options.

These three features **have to be implemented** by a ransomware sample, and
thus have to be visible somehow in the code. Around this key observation,
together with the evil genius [Nicolò Andronio](https://www.andronio.me/) (the
aforementioned Master student) and my partner-in-crime
[Stefano](https://twitter.com/raistolo), we devised and open-sourced
[HelDroid](https://github.com/necst/heldroid), a fully automatic APK analyzer
that, using static flow analysis, detects whether an app contains evidence of
ransomware behavior.

Earlier this summer I've joined [Trend Micro](https://www.trendmicro.com)'
research team, and immediately got my hands onto MARS, its [Mobile App
Reputation Service](https://mars.trendmicro.com/), which allowed me to build
a good retrospective view of how Android ransomware have evolved.

This work granted me a speaking slot at the Black Hat Europe Briefings, where
I had the opportunity to present the results to a room packed with attendees.
Was a great experience!

If you're curious, you can read a summarized version of the research in these
two blog posts:

* [Mobile Ransomware: Pocket-Sized Badness](https://blog.trendmicro.com/trendlabs-security-intelligence/mobile-ransomware-pocket-sized-badness/)
* [Mobile Ransomware: How to Protect Against It](https://blog.trendmicro.com/trendlabs-security-intelligence/mobile-ransomware-protect/)

Or read the full slides and papers linked below.

### References

[@maggi_greateatlonbheu_talk_2016]

[@zheng_greateatlon_2016]

[@andronio_heldroid_2015]
