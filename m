Date: Sun, 30 Jul 2000 07:39:03 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Iain Sandoe <iain@sandoe.co.uk>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Stealth port problems
In-Reply-To: <200007301031.LAA32665@hyperion.valhalla.net>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000730073120.1508F-100000@ofey.inetnebr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 30 Jul 2000, Iain Sandoe wrote:

[...]
> The RX buffer in an 85230 (which is actually the chip - IIRC - an enhanced
> 8530) is 8 characters deep

Ok, this is a news to me.  I'm certain that SCC on oldworld pmacs is
85C30.  When did the change to 85230 occur?  If I remember correctly,
some DMA setup codes in macserial.c need to know about it if it's dealing
with 85230 rather than 85C30.

>                            - so any more that about 700 us IRQ block will
> cause a drop out at 115200 continuous...

With DMA, this is a non-issue as far as serial driver is concerned.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
