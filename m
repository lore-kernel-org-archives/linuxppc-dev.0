From: "Hendricks, Kevin" <khendricks@ivey.uwo.ca>
To: linuxppc-dev@lists.linuxppc.org
Message-Id: <v0311071db5e2dce88539@[129.100.29.243]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 11 Sep 2000 15:04:05 -0400
Subject: Re: Roles for distributions
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

>> There has to be someone there who can at least make builds, file bug
>> reports, and point out when things are broken.  Even that would be a big
>> help.  I filed a make check report with the glibc maintainers and basicaly
>> got back a "we are not interested, fix it yourself if you want it fixed".
>> That generally doesn't happen if someone from ppc is contributing in some
>> way to the project.  Luckily, some of the other glibc developers chimed in
>> to rephrase the reply.
>
>Well, first of all, that's not a general project thing - that's Ulrich
>Drepper's attitude problem.
>
>Secondly, bug reports filed by someone who can just make and make check
>are not terribly useful - no one really has time to dig.  We need
>people who can file bug reports with analysis, and not many people can.

Here is the only point I disagree with.  As a volunteer, I don't even know
if a project needs my help.  The only reason I started testing glibc 2.2
was that there was some noises that it was nearing release and almost every
time glibc comes out it breaks something for native threads which are
really needed by the jdk.

If people regularly do builds, and do "make check" then errors will appear
near in time to recent patches and things (sort of like Linus's only give
me small patches approach) that can tell the maintainers that something is
amiss.  That makes any bugs much easier to find.  My last glibc 2.1.3 patch
was found by doing regular builds to compare different glibc releases and
it was easy to see that Ulrich's post 2.1.3 release breakage was the
culprit.

I can't help fix things if I don't know its broken.  That is why people
doing regular builds, even if that aren't as skilled as Dan, or David, or
Gary or Franz would surely help.

Kevin

--
Kevin B. Hendricks, Associate Professor of Operations and Information
Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
