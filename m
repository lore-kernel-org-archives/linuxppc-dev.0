Date: Thu, 30 Sep 1999 11:21:47 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [Fwd: Bug: 2.2.12 still hangs PPC after some PPP activity]
In-Reply-To: <19990930105030.013866@mailhost.mipsys.com>
Message-ID: <Pine.LNX.3.96LJ1.1b7.990930111227.23148D-100000@ofey.inetnebr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 30 Sep 1999, Benjamin Herrenschmidt wrote:

> I've heard of various possible issues with DMA hardware on the serial
> ports and G3 macs. There seem to be a problem with the Heathrow
> generation of Apple ASICs. (This was reported to me by people who made a
> special device that was plugged into those ports, with a custom driver
> under MacOS). They told me some characters end up beeing garbled when
> reaching the SCC. I'll do some testings with your driver and my
> powerbook's internal modem this week end to see if this problem actually
> occurs or not.

I suppose that can happen if DBDMA's FIFO wasn't flushed properly for
some reason.  Do you know if the problem occurs on receiving side (from
SCC to DMA) or transmitting side (from DMA to SCC)?  How many chars were
garbled?  If the FIFO were the cause of the problem, the number should be
between 1 and 7.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
