Date: Fri, 20 Jul 2001 14:17:51 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: "Joseph P. Garcia" <jpgarcia@execpc.com>,
	Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: powermac (other ppc?) events
In-Reply-To: <20010720102336.13001DBA25@atlas.valhalla.net>
Message-ID: <Pine.LNX.4.10.10107201414210.32605-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > That was my idea in this - have some sound event daemon watch for events
> > and call the proper ioctl. What was with the sound driver only permitting
> > a single open() at a time? Would aumix running block the sound
> > event daemon's ioctl?
>
> The single open() rule is for /dev/dsp ... it is part of the OSS spec.

OK, I assumed it applied for all interfaces.

> Up until my latest set of patches we were breaking this rule.  As of today
> those patches are in Ben's tree but not BK (although they are in my ftp
> space on penguinppc.org as well).

I recalled you mentioned this lately, so I asked :-)

> /dev/mixerXX can be opened multiple times - so this doesn't affect aumix et.
> al.

Fine then. We just need to figure what's the default mixer to use, then.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
