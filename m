Date: Sat, 25 Aug 2001 15:42:33 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michel D?nzer <michdaen@iiic.ethz.ch>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: glibc 2.1 -> 2.2 gotchas?
Message-ID: <20010825154233.S14302@cpe-24-221-152-185.az.sprintbbd.net>
References: <998751333.12597.3.camel@yoda> <01082511424509.15847@localhost.localdomain> <20010826005515.Postino-022357@smtp01.highway.ne.jp> <01082513443402.16172@localhost.localdomain> <3B882749.346A0B39@iiic.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3B882749.346A0B39@iiic.ethz.ch>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Aug 26, 2001 at 12:31:37AM +0200, Michel D?nzer wrote:

> > What I recommend won't hurt and can certainly help flush older shared
> > libraries out of memory.
>
> The point is probably that in the Debian packages, the maintainer scripts take
> care of the necessary steps, so the user doesn't have to.

This always got me tho...  If a program is already running, how do you
make it stop using the old libraries?  If 'restarting' /sbin/init makes it
reload, I'll take your word at it.  But what about all of the other apps that
happen to be running?  The bash session I happen to be doing this upgrade
from.  Or X (yes, in an ideal world, you goto single user to do this
anyhow.. :))

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
