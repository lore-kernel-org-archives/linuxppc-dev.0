Message-Id: <200007130655.HAA16851@hyperion.valhalla.net>
Date: Thu, 13 Jul 2000 07:55:05 +0100
Subject: Re: iBook woes
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Chris Backas <cbackas@bigfoot.com>
CC: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thu, Jul 13, 2000,  Chris Backas wrote:
[...]
> Ok, now for the sound.  Simply put, I've never heard a peep out of this
> thing under Linux.  Is the dmasound module the correct one for the iBook?
> I have 'alias sound
> dmasound' on /etc/conf.modules, and 'lsmod' lists dmasound as loaded (but
> unused). When I start X, I can see complaints from esd that /dev/dsp does
> not exist (it does)
> But perhaps it's not setup properly?

what does cat /dev/sndstat say ?
you should also find some lines in dmesg with "DMA sound" stuff in them...

I'd be interested to know what soundchip you have (AWACS version or is it a
Burgundy) etc.  which you can either find from those entries or from the
MacOS side...

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
