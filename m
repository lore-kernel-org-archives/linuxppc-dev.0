From: Benjamin Herrenschmidt <bh40@calva.net>
To: Iain Sandoe <iain@sandoe.co.uk>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: iBook woes
Date: Thu, 13 Jul 2000 10:53:24 +0200
Message-Id: <20000713085324.18396@mailhost.mipsys.com>
In-Reply-To: <200007130655.HAA16851@hyperion.valhalla.net>
References: <200007130655.HAA16851@hyperion.valhalla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>what does cat /dev/sndstat say ?
>you should also find some lines in dmesg with "DMA sound" stuff in them...
>
>I'd be interested to know what soundchip you have (AWACS version or is it a
>Burgundy) etc.  which you can either find from those entries or from the
>MacOS side...

The iBook don't have an AWACS derivative. It's a different chip. The
basic DBDMA operations are the same, but all the controls go thru an i2c
bus. There's a driver for it in Darwin but not yet in Linux (but someone
is working on it).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
