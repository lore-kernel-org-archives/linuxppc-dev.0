Message-ID: <37EF4436.2489FA65@kieray1.p.y.ki.era.ericsson.se>
Date: Mon, 27 Sep 1999 12:17:26 +0200
From: Marcus Sundberg <erammsu@kieray1.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
To: "sebastien tadeoni" <sebastien_tadeoni@yahoo.fr>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Questions on the MPC8xx-2.3.10 realease.
References: <19990923150552.23602.rocketmail@web601.yahoomail.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


sébastien tadéoni wrote:
> According to Dan, it seems to be tooo difficult to
> cross compile on a host pentium machine (I begin to be
> mainly agree with him),so I'm going to obtain a
> powermac station.
> 
> However I would like to know before if someone has
> already succeeded to build a zImage or zImage.initrd
> configured for a MPC860 MBX board on a host pentium
> (II 400) station?

I build all PPC-Linux stuff on a ix86 PII - kernels and user-space
stuff. Recently only for a custom board, but previously I've built
MBX, ADS and FADS kernels.

There's nothing special about cross-compiling from ix86-->PPC, except
the cross compiling itself. If you haven't built a cross-compiler
before I suggest you have a look at:
http://members.home.net/mmporter/linux/cross/
and
http://www.objsw.com/CrossGCC/

//Marcus
-- 
-------------------------------+------------------------------------
        Marcus Sundberg        | http://www.stacken.kth.se/~mackan/
 Royal Institute of Technology |       Phone: +46 707 295404
       Stockholm, Sweden       |   E-Mail: mackan@stacken.kth.se

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
