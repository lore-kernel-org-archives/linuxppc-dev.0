Message-ID: <394A6392.4C9FAAA0@wanadoo.fr>
Date: Fri, 16 Jun 2000 19:27:46 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: "Timothy A. Seufert" <tas@mindspring.com>
CC: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Interrupt hick ups
References: <Pine.LNX.4.05.10006142236120.5007-100000@callisto.of.borg>
	 <3949DDBD.331E255F@wanadoo.fr> <v04220804b56f910f22ca@[10.0.0.42]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Timothy A. Seufert" wrote:

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

Yes, I did all this, except the -d1 bit which doesn't do anything on my
old drive. The numbers I gave were the maximum I could get with any kind
of tweaking.

Anyway, I am not really complaining (there are far more serious bugs in
-ac16), I guess it was just something too nice to stay for real.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
