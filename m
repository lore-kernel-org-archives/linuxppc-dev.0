Date: Tue, 17 Jul 2001 16:40:24 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4 - buttons, temperature, ictc
In-Reply-To: <20010717101901.21603@smtp.adsl.oleane.com>
Message-ID: <Pine.LNX.4.33.0107171622010.27602-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >With 2.5 even CONFIG_PMAC_BACKLIGHT in adbhid.c will go away and you _have_
> >to use the event devices then, so you better start using them _now_. Taking
> >kernel bloating shortcuts is not the way to go IMHO.
>
> Right, all this belongs to userland. I might include part of this
> patch in 2.4 so we have the feature working now, but for 2.5, I'd
> rather use the event devices for both backlight and volume, and
> have pmud handle them.

Why pmud? For backlight I kind of see how you'd get that notion. But
volume?

I admit to zero knowledge about the event device stuff but if it's
anything like register_event(fd, handler, event_code) or select instead of
having a hander registered I'd rather have some sort of event daemon
handle all this. That way, users could even customize the thing to get
particular functions mapped to keys :-)

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
