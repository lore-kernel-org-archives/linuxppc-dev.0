From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hubert Figuiere <hub-linux-ppc@trantor.staff.proxad.net>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <1064499264.17038.70.camel@trantor.staff.proxad.net>
References: <1064493093.17039.44.camel@trantor.staff.proxad.net>
	 <1064497450.702.12.camel@gaston>
	 <1064499264.17038.70.camel@trantor.staff.proxad.net>
Message-Id: <1064500228.694.18.camel@gaston>
Mime-Version: 1.0
Date: Thu, 25 Sep 2003 16:30:28 +0200
Subject: Re: kernel panic in slab.c
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Fine, then I feel like investigating it since memory corruption are
> probably the worst bugs. I don't have a good handle on the problem. I
> often crash while running either "bird" or "swapper" (uptime don't
> exceed 5 or 10 minutes). Even worse, sometime it crashes during boot up.
> The only thing I'm sure is that it is fully reproducible as it plagged
> me for quite sometime. I first thaught that hardware was at fault (like
> defective MPU), but my co-workers don't have the problem, and in fact
> disabled debugging.

Great, let me know what you find out.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
