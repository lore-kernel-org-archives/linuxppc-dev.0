Date: Fri, 20 Jul 2001 11:22:44 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: "Joseph P. Garcia" <jpgarcia@execpc.com>,
	Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: powermac (other ppc?) events
In-Reply-To: <20010719223636.DAB40DBB56@atlas.valhalla.net>
Message-ID: <Pine.LNX.4.10.10107201043460.32605-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Look, I don't have a proper opinion on how the keys are achieved ...
>
> ---
>
> all I want is that the sound driver is:
>
> 1/ called through the standard ioctl() for volume - however many "volumes"
> you want to adjust.
>
> This is so that *your* interface will work with *any* dmasound-supported
> hardware (without hacking dmasound for each chipset).

That was my idea in this - have some sound event daemon watch for events
and call the proper ioctl. What was with the sound driver only permitting
a single open() at a time? Would aumix running block the sound
event daemon's ioctl?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
