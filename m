Message-ID: <3AAFC805.AE1CA2B@mvista.com>
Date: Wed, 14 Mar 2001 11:35:33 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: walnut 405
References: <3AAF73C0.D0DA94A6@inn.ericsson.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kenneth Johansson wrote:
>
> I have finally got my walnut card from IBM and compiled linux for it.
> I used the version from Frank (mvista) on area51 dated 01_03_03 but changed
> the configuration to remove kgdb and enable float emulation.
>
> Things looks quite good I now have a debian potato for ppc running on the card
> but there is a few problems.
>
> 1. It kills the Ethernet port on a cisco catalyst 5505 switch/router.
>    This is something I never seen before but when I use a port that is 10Mb
> linux sends out something that the switch dose not like and it simply
> disable the port. I put a 3com 10Mb hub between but the same problem so it's
> not electric. I was however unsuccessful in getting any useful information
> from the network people on what rule was violated. It dose not happen on a
> 100Mb port. I guess that it is some clock or timing that is wrong in the
> Ethernet driver.

Can you get a network trace to see what packets are involved?


> 2. it's not possible to run gdb

Yes, ptrace is still not yet implemented for the 4xx.  This means that both gdb
and gdbserver do not work.  I have been working on this but don't yet have a
robust version in place.  I hope to have this available very soon.  (If anyone
feels like debugging this, I can send them my current patch.)


> 3. dpkg segfaults
>    It's quite easy to get into a state where dpkg segfaults. A reboot fixes
> the problem. To get into the mess again all you have to do is start emacs.
>
> On the bright side alot of stuff works. I did the kernel compile test and that
> worked.
>
> If anybody want's to run debian I could write a small howto but I'am not going
> to do that if nobody ask's for it.

Kenneth,

Thanks for the feedback.


-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
