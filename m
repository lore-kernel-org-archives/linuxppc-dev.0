Message-ID: <392BAB64.DBF54B54@execpc.com>
Date: Wed, 24 May 2000 05:13:56 -0500
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: Sergio Brandano <sb@dcs.qmw.ac.uk>
CC: Stephan Leemburg <stephan@jvc.nl>,
        Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org
Subject: Re: PMUD vs APM
References: <B5514D3F.E6B3%stephan@jvc.nl>  <392B854B.F9AC566E@execpc.com> <200005240959.KAA18934@copper.dcs.qmw.ac.uk>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sergio Brandano wrote:
> > Its almost as good as Batmon, but smaller.
>
>  I find gkrellm way better than Batmon. Why do you say ``almost''?
>  Why is Batmon still better than gkrellm-pmud? (it results to me that
>  the underlying code was written by Paul...)

testing, and a few features.  as a battery monitor, gkrellm-pmu has the needed
features.  Ohare-based systems seem to have a temperature sensor on the battery
though.  One of those testing things.  I only have access to my PDQ/300. :(

>  It would be a good thing, however, to have a unified monitoring
>  system despite the hardware. I mean Intels are based on apm, PPCs are
>  based on pmu, but do applications need to know it?

My 0.02 on the matter is that we don't really need to bow down to APM, just
support it.  There may be a few programs out there that do stuff with APM that
we dont need to reinvent.  example that may or may not exist, an dialog box that
pops up warning low battery.  But since PMU has the ability to list additional
information (current, 2 batteries), why not use it?  I prefer knowing more than
just batt/ac and charge.  But others might not care. In the end, I suppose its
better to support APM than not to.

I plan on updating my plugin later today.  RPMs and locales.. oooh.

--
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

"Did you ever notice how the Chinese Abacus, with 2 '5' beads and 5 '1'
beads, is perfect for hexidecimal math?"

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
