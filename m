Date: Mon, 10 Feb 2003 10:25:30 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Cc: "Ruhland, Paul" <PRuhland@microwavedata.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] 8xx_io/uart.c
Message-ID: <20030210172530.GA20757@ip68-0-152-218.tc.ph.cox.net>
References: <A60FFE6CA339C742BE11C311EA8BFF540164DD@mdsms2.inside.mdsroc.com> <IGEFJKJNHJDCBKALBJLLCECBFKAA.joakim.tjernlund@lumentis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <IGEFJKJNHJDCBKALBJLLCECBFKAA.joakim.tjernlund@lumentis.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Feb 10, 2003 at 03:45:41PM +0100, Joakim Tjernlund wrote:
>
> > The pasting into the console bug is actually caused in
> > 'drivers/char/n_tty.c' (standard tty line discipline) by not handling a
> > failed call to 'opost(...)' (if returns -1 if tx buffer is full and char
> > must be retried) in 'echo_char()'.  The pasted data is received fine....just
> > the echo fails.
> >
>
> Hi again
>
> Thanks to Paul Ruhland I was able to fix my problem with chars getting
> lost.
>
> This little patch of mine works really fine for me, I just want to known
> if it's a good solution or if something else is to prefer.

Bring it up on linux-kernel@vger.kernel.org.  A brief description and
this patch should be enough to get people to listen.  Maybe send it to
Alan Cox too..

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
