Message-Id: <v03110700b4eec4979817@[129.100.29.243]>
In-Reply-To: <v03110701b562ab7246aa@[129.100.29.243]>
References: <38C7A233.DC4C803C@iiic.ethz.ch>
 <Pine.LNX.4.21.0003060013070.30614-100000@idd-01.imbc.gr>
 <00030822191300.00546@localhost.localdomain>
 <38C7A016.8C2ED4C8@iiic.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 10 Mar 2000 10:33:24 -0500
To: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>,
        Michel Dänzer   <michdaen@iiic.ethz.ch>,
        Kostas Gewrgiou <gewrgiou@imbc.gr>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to work on pp
    cwithr128
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

So Xfree 4.0 final is out but without the very last minute cache flushing
changes Kostas made.

So we should probably get some official patch out there that includes a few
elements:

1. Either:
       - user defined cache line size during compile
   or:
       - flush a cache range in address increments of 8

to handle the variable line cache size

2. And something to figure out if we are on a 601 machine in the
NuBus X100 machines to properly do a "sync or eieio" so that XFree86 4.0
cache flushing and synchronization for io has some chance of working under
MkLinux R1.

David can you tell me how the 601 problems with sync and eieio are
detected and handled in user space apps under MkLinux?

Thanks,

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
