Date: Mon, 18 Aug 2003 11:02:09 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Florian Schirmer <jolt@tuxbox.org>
Cc: "'Andreas Oberritter'" <obi@saftware.de>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: new code for an mpc8xx board (dbox2)
Message-ID: <20030818180209.GD848@ip68-0-152-218.tc.ph.cox.net>
References: <20030804172428.GD20708@ip68-0-152-218.tc.ph.cox.net> <000f01c35ad0$7b8d6fb0$6401a8c0@space.taytron.net> <20030804231248.GE20708@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030804231248.GE20708@ip68-0-152-218.tc.ph.cox.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Aug 04, 2003 at 04:12:48PM -0700, Tom Rini wrote:

> On Mon, Aug 04, 2003 at 11:36:34PM +0200, Florian Schirmer wrote:
[snip]
> [snip]
> > I would like to see the userspace interface merged too
> > (http://cvs.tuxbox.org/cgi-bin/viewcvs.cgi/tuxbox/driver/wdt/mpc8xx_wdt.c).
> > I propose to drop the kernel watchdog patch and merge in the following
> > functions of the userspace interface instead:
> >
> > mpc8xx_wdt_reset (needs to be exported to modules)
> > mpc8xx_wdt_interrupt
> > mpc8xx_wdt_handler_install (has to called during kernel init)
> >
> > mpc8xx_wdt_handler_remove is dead and can be removed.
>
> I need a bit of time to think about this (and a 'new' patch would be
> nice as well).  I'll get back to you.

Okay.  After reading the driver above, I would be fine with you submitting
this to Marcelo once 2.4.23-pre1 opens, and submitting it to 2.6 as well
(yes, you won't be able to test it, but you can at least see if you
ported the driver 'up' right).

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
