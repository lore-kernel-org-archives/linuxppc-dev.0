Message-ID: <3C987DEB.14F4E05A@imc-berlin.de>
Date: Wed, 20 Mar 2002 13:17:47 +0100
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Steve Rossi <srossi@labs.mot.com>
Cc: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: IDE DMA on 8xx ??
References: <3C20E057.B9983C96@labs.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Steve,

> Has anyone attempted to use the internal 8xx IDMA controller to do
> DMA to a IDE disk? I'm considering making an attempt at it, but I just
> want to hear first if anyone has tried already and if so what the
> experience is.

I did last summer. Well actually I tried. It wasn't too hard to use the
IDMA to transfer data from/to ide disk.

But at that time my code just started polling after setting up the dma.
So the cpu was busy waiting instead of doing something useful. But I
reckon it's not to hard to use irqs for signaling the end of DMA
transfer to the ide driver.

I noticed that the cycle time of the normal (i.e. two-address) IDMA mode
is huge. So the performance wasn't great.

I have to pick up that work again now.

So I wonder if you or anybody else has done something on this topic?

Thanks,

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
