Date: Wed, 28 Mar 2001 15:31:10 -0600 (CST)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: "Michael R. Zucca" <mrz5149@acm.org>, phandel@cise.ufl.edu,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Sound stoppage
In-Reply-To: <20010328070644.8D1F9DB9D3@atlas.valhalla.net>
Message-ID: <Pine.A41.3.96LJ1.1b7.1010328152002.32200D-100000@unlserve.unl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 28 Mar 2001, Iain Sandoe wrote:

> are you sure it will re-start *part way* through a dbdma command (and not
> just re-send the entire block)?   (the latter is what sound dma seems to
> do).

No, not sure at all.

> It doesn't appear to make sense to resume part of a block on ethernet...
> (i.e. once you've missed the Xmit deadline the packet is trashed - so you'll
> have to re-send anyway).

I agree it would make more sense to resend the whole thing, and that's
probably what mace dbdma does.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
