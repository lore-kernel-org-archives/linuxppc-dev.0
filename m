Date: Wed, 17 Sep 2003 08:08:45 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problems w/  CONFIG_BLK_DEV_MPC8xx_IDE
Message-ID: <20030917150845.GB14509@ip68-0-152-218.tc.ph.cox.net>
References: <3F656CFC.1050706@imc-berlin.de> <3F65A2FD.3010904@imc-berlin.de> <1063627208.14615.21.camel@trantor.staff.proxad.net> <3F65B091.1020802@imc-berlin.de> <20030915151648.GD29517@ip68-0-152-218.tc.ph.cox.net> <3F66CCFD.3040301@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3F66CCFD.3040301@imc-berlin.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Sep 16, 2003 at 10:42:37AM +0200, Steven Scholz wrote:
> Tom,
>
> >>I just noticed that I might have used the wrong source tree.
> >>
> >>So which is the BK tree to use:
> >>
> >>linuxppc_2_4_devel or linuxppc-2.4 ???
> >
> >
> >It depends on where what you want to use exists.  If something is in
> >_devel and not in linuxppc-2.4, patches to move features over one at a
> >time would be happily reviewed.
>
> ???
> So which is the most recent?

Aside from possible changes to match upstream subsystem rewrites (such
as IDE) there hasn't been any changes in linuxppc-2.4 specific to 8xx
that didn't happen in 2_4_devel.

> http://www.penguinppc.org/dev/kernel.shtml calls linuxppc_2_4_devel the
> "old PPC development tree" !?

That's correct.  It's becoming more of a pain to maintain or own set of
trees to track 2.4 when Marcelo uses BK as well.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
