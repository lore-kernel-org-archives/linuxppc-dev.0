To: brian.auld@adic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel boot: 'Kernel command line' not getting bootargs????? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 04 Feb 2003 14:57:10 PST."
             <995FF289C9D69747A09E42992644595405B2364B@penguin.adic.com>
Date: Wed, 05 Feb 2003 00:23:20 +0100
Message-Id: <20030204232325.E7242C608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <995FF289C9D69747A09E42992644595405B2364B@penguin.adic.com> you wrote:
> My bad. It's a good thing I'm not a pilot, I guess.

:-)

> I broke the boot sequence into steps (printenv, bootp, printenv, bootm) just
> for posting to this list, and missed the bootargs.
>
> HOWEVER, I still see the exact same problem when I execute 'run bootcmd'
> according to the 'printenv' listed below ... in which case 'bootargs' should
> be set.

I see.

Sorry, not having a Ebony board here for reference I dont know what's
happening to you. You may want to attach a BDI2000 and debug the boot
sequence (check for the arguments passed to the kernel).

> One more thing. I have to enter the 'run bootcmd' at the u-boot prompt. If I
> don't, there is no timeout and I just sit at the prompt forever. The way the
> PPCBoot Guide reads, it should boot automatically, but it doesn't. Is there
> something I'm missing here?

The default U-Boot config file for the Ebony board includes:

#define CONFIG_BOOTDELAY        -1                  /* disable autoboot */

Define some useful delay here (say 5  for  5  seconds)  and  re-build
U-Boot.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
You could end up being oddly sad and full of a strange, diffuse  com-
passion  which would lead you to believe that it might be a good idea
to wipe out the whole human race and start again with amoebas.
                                 - Terry Pratchett, _Guards! Guards!_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
