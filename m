Date: Thu, 18 Jan 2001 20:03:03 -0600
Subject: Re: [PATCH] 2.4.1p4 : dmasound ed21- Pismo byte-swap
From: Takashi Oe <toe@unlserve.unl.edu>
To: Iain Sandoe <iain@sandoe.co.uk>, <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B68CFC76.583E%toe@unlserve.unl.edu>
In-Reply-To: <20010119014611.67C3F2F00B@apollo.valhalla.net>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 1/18/01 7:47 PM, Iain Sandoe wrote:

[...]
> ... by comparison with the large amount of other code already in there to do
> rate expansion and compression/decompression it is a relatively small price
> to pay for having all pmac machines behave the same...

I know it's a small price, and some of those translations shouldn't be there
either, I think.

> ... at the next revision of the driver we could try issuing it with "16bit
> 44k1 Signed BE" only - and see how much of the desktop world works ;-)

Let's fix apps and keep the kernel lean.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
