Message-ID: <3831DE3B.5F2C790@wanadoo.fr>
Date: Tue, 16 Nov 1999 23:44:11 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Dev-Linux <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Kernel debugging??
References: <Pine.LNX.4.05.9911161844270.25661-100000@callisto.of.borg>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:

> > And I could boot a stock 2.3.26 with changes in asm-ppc/fcntl.h
> > (O_LARGEFILE ....)
> 
> That's very interesting to know! It means we just have to analyse the 2.3.27
> and 2.3.28 patches to find out what went wrong.

Just for information: Paul M's 2.3.27 rsync kernel compiles and runs
just fine on this Pmac 6400. The machine swaps like crazy and is
therefore rather slow, but I am not sure if this is the kernel's fault.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
