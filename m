Message-ID: <3949E6C7.877E7655@pop.agri.ch>
Date: Fri, 16 Jun 2000 10:35:19 +0200
From: Andreas Tobler <toa@pop.agri.ch>
MIME-Version: 1.0
To: "Timothy A. Seufert" <tas@mindspring.com>
CC: Martin Costabel <costabel@wanadoo.fr>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: ide-speed was Re: Interrupt hick ups
References: <Pine.LNX.4.05.10006142236120.5007-100000@callisto.of.borg>
	 <3949DDBD.331E255F@wanadoo.fr> <v04220804b56f910f22ca@[10.0.0.42]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Timothy A. Seufert" wrote:
>
> At 9:56 AM +0200 6/16/00, Martin Costabel wrote:
> >What is gone too, unfortunately, is the phenomenal IDE speed
> >improvement. In late 2.3.99/early 2.4.0-test1, I had a "hdparm
> >-t"-measured throughput more than 3 times as high (almost 6MB/sec,
> >sometimes more) as with 2.2.x (1.90MB/sec). It diminished in -ac15
> >(3.25MB/sec), and in -ac16 it is almost back down (2.30MB/sec) to the
> >2.2.x values.
>
> Have you made sure your HD is set up for DMA, etc.?  For example, do
> "hdparm -d1 -u1 -m16 -p4 /dev/hda" and then run the -t throughput
> test.  (Use the man pages to make sure those are sane options, that's
> all from memory.)
>
> I remember similar fluctuation in 2.2.x as automatic negotiation of
> DMA and so forth was first put in then taken out of the IDE driver.
>
> Also, to make sure buffers get flushed before a test (for repeatable
> results) you should do hdparm -Tt, not just hdparm -t.

Aha, just made a test and saw the same as Martin. Now with the hint from
Tim I get back to 6.30MB/s on ac19
On 2.2.16 it is still 6.xMB/s.
So now the question is for me what does the kernel parameter
hda=autotune do?
Do I always have to set this line by 'hand'(script) "hdparm -d1 -u1 -m16
-p4 /dev/hda"?

Thanks
Andreas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
