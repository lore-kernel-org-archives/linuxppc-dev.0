Message-ID: <3A87C704.49180399@mpifr-bonn.mpg.de>
Date: Mon, 12 Feb 2001 12:20:36 +0100
From: Albrecht =?iso-8859-1?Q?Dre=DF?= <ad@mpifr-bonn.mpg.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PCMCIA on a Pismo with pcmcia-cs-3.1.24
References: <3A87A3F6.6A9CA4C7@mpifr-bonn.mpg.de> <19350107044033.16629@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
> >>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
> >
> >These entries look suspicious, and they do not work for sure with our pismos.
>
> These are correct for a 2.2 kernel. 2.4 will have something like
> primary=01, secondary=02, ...

The working config on the Lombard is

00:13.0 CardBus bridge: Texas Instruments PCI1211
	[...]
        Bus: primary=00, secondary=01, subordinate=04, sec-latency=176

and on the Pismo

00:1a.0 CardBus bridge: Texas Instruments PCI1211
	[...]
        Bus: primary=00, secondary=01, subordinate=04, sec-latency=32

These are the same bus settings as with MacOS, but I must admit that I do not
know exactly what they are for... The default values with the unpatched kernel
if booting with yaboot do not work at all, at least with the 2.2.x series.

Albrecht.

--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
