From: Alan Mimms <alan@packetengines.com>
To: greyham@research.canon.com.au (Graham Stoney),
        pavel_roskin@geocities.com (Pavel Roskin)
Subject: Re: Download timeout problems on Embedded Planet CLLF (was Patch for zsrec.c)
Date: Mon, 31 Jan 2000 17:07:52 -0800
Content-Type: text/plain
Cc: linuxppc-embedded@lists.linuxppc.org
References: <20000201005642.914451B3E8@elph.research.canon.com.au>
In-Reply-To: <20000201005642.914451B3E8@elph.research.canon.com.au>
MIME-Version: 1.0
Message-Id: <00013117084009.00776@alan.corp.packetengines.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I had this problem on a busy 10Mb shared wire.  My guess is they are handling
collisions wrong in their low level driver?  It works FINE at home on my three
machine network, which although also 10Mb is pretty well idle when I'm
downloading most of the time.

a

On Mon, 31 Jan 2000, Graham Stoney
wrote: > Pavel Roskin writes:
> > The sentence about buggy RPX boards should be removed from
> > getting_started.rpx
>
> Your patch might fix the error on the last record, but I'm having no end of
> trouble with the download timeouts (which Dan also mentions in that paragraph
> of getting_started.rpx) on our CLLF boards. I don't seem to be making any
> progress with Embedded Planet technical support on this either -- they say
> they haven't reproduced the problem.
>
> Are other people also having problems with download timeouts on Embedded Planet
> boards? (or even if you're not, I'd love to hear what you're doing different).
>
> Thanks,
> Graham
--
Alan Mimms     Packet Engines, Inc.     Spokane, Washington [99214-0497]
  USA, Earth, Sol, Milky Way, The Local Group, Virgo Supercluster, U0
Despite the cost of living, have you noticed how popular it remains?
  -- Steven Wright?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
