To: Marco Schramel <Schramel.Linux@go.bartec.de>
Cc: "PPC_LINUX" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Init hangs 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 06 Aug 2004 08:26:21 +0200."
             <200408060826.21301.Schramel.Linux@go.bartec.de>
Date: Fri, 06 Aug 2004 10:11:46 +0200
Message-Id: <20040806081151.B77FCC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200408060826.21301.Schramel.Linux@go.bartec.de> you wrote:
>
> Searching the outputfile of ethereal tells me that the last working nfs LOOKUP call is the libc-2.3.1 call. After this and a lot of Read Call, Read Reply transfers the Target doesn't answer the host.
> (ARP  "who has targetip-address?"). Before this, the ld.so.preload LOOKUP call fails.
> (History: dev, console, sbin, init, lib, ld.so.1, ld-2.3.1.so, etc, ld.so.preload (fails), ld.so.cache, libc.so.6, libc-2.3.1, than it crashes). Is the ld.so.preload necessary?

No, it's not necesary. It's normal that this lookup fails.

Looks as if your init is crashing.

Try running a (statically linked)  shell  instead  (by  passing  some
init=/bin/sh" option on the boot command line).

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
It is easier to write an incorrect program than understand a  correct
one.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
