Message-ID: <392BB72D.78EBA12A@wibble.net>
Date: Wed, 24 May 2000 21:04:13 +1000
From: Steven Hanley <sjh@wibble.net>
MIME-Version: 1.0
To: Sergio Brandano <sb@dcs.qmw.ac.uk>,
        Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PMUD vs APM
References: <B5514D3F.E6B3%stephan@jvc.nl>  <392B854B.F9AC566E@execpc.com> <200005240959.KAA18934@copper.dcs.qmw.ac.uk>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  It would be a good thing, however, to have a unified monitoring
>  system despite the hardware. I mean Intels are based on apm, PPCs are
>  based on pmu, but do applications need to know it?

hopefully I am not rambling or overly much off topic here...

Agreed, common user space interfaqces so any tools in userspce can
access and use the features. Stephen Rothwell is the APM maintainer
(kernel space) and he works in the same office as Paul, I have asked
Stpehen in the past about any similarities between APM and power book
powersaving interfaces and he has said it is completely different, this
is undersatrandable. Paul of course has a verry good power management
system set up on his laptop (lombard ?) of course.

But if someone were to sit down and work out what power management is
all about and some way of displaying a common extensible interface from
kernel to user space it would be good. Thus we could have ACPI (or
whatever the new one is called) and APM and PMUD code in the kernel
providing interfaces any tools can work with. What they do in kernel
space is their business (the completely different parts Stpehen
mentioned)

It would need to be extensible and standardised, so say some new thing
becomes available in power management tools can support it easily and
not break etc etc. ie. be able to present all capabilites and new
capabilities as they appear etc etc. I am sure people understand the
ideas, anyway I agree a common user space interface would be a good
thing. I personally dont have a laptop (or currently spare time <g>,
then who has any of that?) and I dont even know if my 7220/200 has power
management hardware in it. Though my dual pII/350 I know has both APM
and ACPI support, though I have never used either, as APM is undefined
on SMP (well apart from the power off on shutdown trick, and even that
took a while to get working) and I have yet to see a need to try to use
ACPI on the dual box.

	See You
	    Steve

--
sjh@wibble.net http://wibble.net/~sjh/
Look Up In The Sky
   Is it a bird?  No
      Is it a plane?  No
         Is it a small blue banana?
YES

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
