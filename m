To: greyham@research.canon.com.au (Graham Stoney)
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: FEC ERROR 41200000 on CLLF-860T
References: <19991212235604.AF1D4F4E5@elph.research.canon.com.au>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 15 Dec 1999 17:20:03 +0100
In-Reply-To: greyham@research.canon.com.au's message of "Mon, 13 Dec 1999 10:56:04 +1100 (EST)"
Message-ID: <kfyd7s86urw.fsf@kieraypc07.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


greyham@research.canon.com.au (Graham Stoney) writes:

> Marcus Sundberg writes:
> > No, Graham was expecting/hoping for 8 M _bytes_, not bits.
> > So in fact it's actual performance is about 1/3 of that, which
> > I pointed out to him.
> 
> Marcus is right; we'd like to use all the bandwidth available on the FEC for
> optimal system performance. Can anyone elaborate or provide pointers to more
> information on the FEC throughput issue? Is there really a hardware problem in
> the CPU, or is it a board specific issue?

I did some more quick testing.
The bottleneck seems to be the context-switching of Linux. When
increasing the amount of data sent per sendto() call to 11k I got
41Mbit, and with 22k I got 46Mbit. If bandwidth is very important,
maybe you should consider using an 80MHz 860P instead of the 860T.

//Marcus
-- 
Signature under construction, please come back later.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
