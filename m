Message-Id: <200301221443.PAA15378@hzsms01.nl.lucent.com>
Date: Wed, 22 Jan 2003 15:43:53 +0100 (MET)
From: Jaap-Jan Boor <jjboor@lucent.com>
Reply-To: Jaap-Jan Boor <jjboor@lucent.com>
Subject: Re: Lauterbach ICD In-Circuit Debugger
To: linuxppc-embedded@lists.linuxppc.org, r&d@wawnet.biz
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> A lot of people suggest to use the Abatron BDI2000 as debug system. I used
> the Lauterbach TRACE32-ICD system with ARM processors without MMU (no
> Linux) and it works extremely well.
> The manufacturer claims it fully supports both the MMU and the Linux kernel
> (see here for more details
> http://www.lauterbach.com/cgi-bin/docloc.pl?file=rtoslinux.pdf). Can
> anybody who used it confirm this point?

I can. You can debug the kernel and e.g. interrupts using virtual
addresses very well, you just have to specify the mapping
(e.g. for ppc map phys 0x00000000 to 0xc0000000)

I've not looked in detail yet to debug user processes.

Jaap-Jan

>
> Many thanks in advance.
>
>
> llandre
>
>
>

---
J.G.J. Boor
Lucent Technologies Nederland b.v.	Room:  BE-525
Optical Networking Group TMS Data 	Phone: +31 (0)35 687 4721
Larenseweg 50, P.O. Box 1168, 		Fax:   +31 (0)35 687 5976
1200 BD, Hilversum, The Netherlands	mailto:jjboor@lucent.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
