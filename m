From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Lite5200 PCI not working
Date: Tue, 22 Jun 2004 08:08:40 +0200
Cc: Mark Jonas <mark.jonas@gmx.de>,
	=?iso-8859-1?q?I=F1igo_Lopez_Barranco?= <ilopez@albatros-sl.es>
References: <42A622EB18325843894BB8E1040E3DF5022753@sinaexchf> <40D734CE.9090502@gmx.de>
In-Reply-To: <40D734CE.9090502@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406220808.41005.g.jaeger@sysgo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

On Monday 21 June 2004 21:19, Mark Jonas wrote:
> Iñigo,
>
> I experienced this behavior with an USB card before. With that card the
> reason was a short on the USB card between 3.3V and 5V supply pins. In a
> normal PC this seems to be no problem (maybe because a PC's PCI ports
> are 5V only).

there seem to be more cards like these, they're in fact badly designed - they
shorten the VI/O pins and 5V on the card, which could cause some trouble
on the Lite5200, as the VI/O stuff is directly connected to the RAM chips and
their I/O does not like the 5V...
We sorted out some cheap networking adaptors...

> The Lite5200 survived.
"What a lucky man he was" :-)

> To be sure if this is the problem I recommend testing the card for the
> short.

That's a great idea, check esp. shortage between the VI/O and 5V lines on the
card...

Gerhard


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
