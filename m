Date: Wed, 18 Jul 2001 22:10:46 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Bastien Nocera <hadess@hadess.net>
Cc: Iain Sandoe <iain@sandoe.co.uk>,
	"Joseph P. Garcia" <jpgarcia@execpc.com>, <benh@kernel.crashing.org>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4 - buttons, temperature, ictc
In-Reply-To: <3B5586AB.7000604@hadess.net>
Message-ID: <Pine.LNX.4.33.0107182204380.2441-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >>>Why pmud? For backlight I kind of see how you'd get that notion. But
> >>>volume?
> >>>
>
>
> Why would pmud make sense for the backlight ? because changing the
> backlight settings saves power ? ..Right.

Sort of.

> With Ben's latest changes (the /proc/pmu/* for example), pmud should
> only be a daemon waiting for events, ie:
> - sleep event: execute a bunch of shell commands (the pwrctl script
> should really be split into foo.d directories)

Yep. Plus any other power status change events. /proc/pmu has got nothing
to do with it, neither has /proc/apm.

> - backlight keypress event: change the backlight

Nope. Not power related. Not 'PMU'd.

> - volume keypress event would be a bad idea to implement inside pmud
> because that's the kind of thing you want visual feedback for, and there
> are a lot of different sound implementations that this could be built on
> top of. (aRts/alsa/oss)

Nope. See above.

> - eject keypress event: eject the damn CD !

Neither. Again, see above. Write a general purpose all powerful event
daemon for this. Don't bloat pmud because of some unspecific desire for
feeping creaturitis. This is Linux (Unix), not MockOS.

> Better yet for handling the volume would be to get all these keys
> recognized by the Linux kernel (these keys don't produce any recognized

Nope, not longer an option (kernel bloat, even worse than app bloat).

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
