---
title: What we Know About EyePyramid
tags: [malware, espionage, italy, trendmicro]
date: January 18, 2017
short: |
    Two Italian brothers have been arrested for planting and managing
    a long-running malware operation to spy on several high-profile politicians
    and businesspersons. In this post, I give my side of the investigation.
---

The day before the EyePyramid case exploded, I received a confidential email
with a PDF. It was the scanned copy of the court order for the law enforcement
to proceed and arrest the Occhionero brothers. In a few minutes, I noticed that
this leaked document was also circulating on various private mailing lists and
chat groups I'm part of. At some point, I received a non-redacted copy.

<div class="videoWrapper"><object data="ordinanza-occhionero.pdf" type="application/pdf" width="100%" height="100%"><iframe src="ordinanza-occhionero.pdf" width="100%" height="100%" style="border: none;">
Here you can download a copy of <a href="ordinanza-occhionero.pdf">the PDF</a>.
</iframe></object></div>

I typically do not work on e-crime investigation cases, but while reading the
court order I felt that something was not completely right. Moreover, the case
was in Italy, my home country, which motivated me to look at it. Then, some
colleagues from Trend Micro Italy contacted me with questions coming from our
clients (for which, back then, I couldn't answer yet). So, at the end of the
day I decided to dive in!

### Puzzling Facts in the Court Order
I skimmed through the court order and was surprised by the vast amount of
technical evidence provided to support the accusations. Email addresses (in
clear or easy to guess when redacted), IP addresses, domain names. So detailed
that I could basically write a Yara rule to hunt for malware samples, without
even looking at a single binary.

And then, the part that puzzled me most. The author of the malware used
a licensed software library and allegedly *purchased the license under the name
of Giulio Occhionero* (one of the two brothers). It's like, leaving your name
on the crime scene!

### (Almost) Live Reversing
After getting my hands on some samples (yes, with Yara hunting rules based on
the court order), things escalated quickly, and found myself looking at nearly
250 samples. With the help of my fine colleagues, we've drawn rough, big
picture of the whole scheme and started to find confirmatory evidence.

In a few hours, people on Twitter and other social networks started to follow
the case closely, comment on it, give their own views. Given some confusion,
I felt the urge to publish a list of "cold, simple, yet true" technical facts.
So I've spun up a GitHub Gist (now deleted), which then evolved in a [full
repository](https://github.com/eyepyramid/eyepyramid) (now not updated
anymore), and finally [a post on Medium (in
Italian)](https://medium.com/@phretor/cosa-sappiamo-su-eyepyramid-61b5b88c63b8).
Results were popping up rapidly, so I found myself unable to keep up with the
pace, and decided to stop "live reversing" the samples, set aside some time and
prepare two comprehensive posts for TrendLab's Intelligence Blog, which my
employer was very happy to release in no time.

* Jan 18, 2017 - [Uncovering the Inner Workings of EyePyramid](https://blog.trendmicro.com/trendlabs-security-intelligence/uncovering-inner-workings-eyepyramid/)
* Jan 11, 2017 - [The Eye of the Storm: A Look at EyePyramid, the Malware Supposedly Used in High-Profile Hacks in Italy](https://blog.trendmicro.com/trendlabs-security-intelligence/eye-storm-look-eyepyramid-malware-supposedly-used-high-profile-hacks-italy/)

### Summary of the Case
On the one hand, the original source code had gone through only very mild
modifications (e.g., not all variants are able to exfiltrate Skype
conversations, C&C and dropzones, compiler version, and protection mechanisms).
On the other hand, the computer(s) used to build the various versions over the
years seemed to be in line with the evolution of Microsoft developer tools
(based on the progression of the compiler version) and software-protection
tools (as seen on the recent substitution of Skater plus Dotfuscator with the
more powerful ConfuserEx). This indicates that the actors behind this operation
knew what they were doing. Of course, this was (and still) far from being an advanced
or targeted piece of malware.

Apart from this, the origins of EyePyramid’s malware and its attribution remain
a mystery. While the license key registered to Giulio Occhionero’s name can be
considered as strong evidence, it is unclear why a malware author would bother
using (simple yet not so trivial) mechanisms to cover their traces (e.g.,
obfuscation, packing, encryption, disabling security tools), and then
mistakenly embed the license key under his name in all of the main variants.
Moreover, an analysis of the domain-to-IP historical data of the domain names
listed in the court order reveals domains named `occhionero.com` and
`occhionero.info`, which is again another oddity.


### Latest Update (Just Another Oddity)
I received an unexpected email message from someone I've never heard before.
Despite the author of this email is not known in the cyber security community
(he presented himself as a PhD Student in medicine at Stanford), he took the
time (and money) to verify every single email address written in my analysis
and in the court order.

Using LeakedSource (now taken down) he had found that one of the compromised
email addresses (`lu_1974[@]hotmail.com`, which is linked to EyePyramid) was
used to register on various dating sites. LeakedSource was borderline websites
that hosted stolen information, including usernames and
passwords.

> _“this is probably just a coincidence”_ he said but _“Giulio also used his
> `@westlands.com` address to register to the same dating sites.”_

Anyways, I've replied back, thanking him for his work. Then I've asked him why
a Stanford PhD Student in medicine was so interested in such “niche” case
(unfolded from the other side of the world), and how he knew that Giulio
Occhionero had used his `@westlands.com` address to register to the same dating
sites, because I could not find any evidence about it

I've never gotten a reply.

### Media
After getting in touch with [Carola Frediani](https://twitter.com/carolafrediani), who did a very good job consolidating all the facts for La Stampa ([Tutti i dettagli e i misteri di EyePyramid](http://www.lastampa.it/2017/01/12/italia/cronache/tutti-i-dettagli-e-i-misteri-di-eyepyramid-S3vOtTe6smhbJbBlrogpcJ/pagina.html)), I happily joined the hacker's corner at the International Journalism Festival 2017 in Perugia, a few months later, in a panel moderated by Carola. Here's the recording of the panel.

<div class="videoWrapper"><iframe src="https://www.youtube-nocookie.com/embed/icgJavQqICM" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe></div>
