Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Date: Mon, 17 Nov 2003 11:50:18 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Cc: Dale Farnsworth <dale@farnsworth.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC5200 Patches
Message-ID: <20031117185018.GG30251@ip68-0-152-218.tc.ph.cox.net>
References: <20031112151824.GC31581@ip68-0-152-218.tc.ph.cox.net> <20031116203318.21D9CC5F59@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031116203318.21D9CC5F59@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Nov 16, 2003 at 09:33:13PM +0100, Wolfgang Denk wrote:

>
> Dear Tom & Dale,
>
> in message <20031112151824.GC31581@ip68-0-152-218.tc.ph.cox.net> you wrote:
> >
> > Can I suggest breaking the trend slightly based on comments people have
> > made about 2.5/2.6?  Let's call it CONFIG_PPC_5xxx (and someday fix all
> > of the others).
>
> OK, so the discussion has stopped. What's happening now? I  sent  our
> stuff.  Dale  has  added some modification. We have more works in the
> queue. I think it makes little sense to  continue  without  a  common
> code base.

Okay.  I've populated the following tree with what Dale had.  Since
there's a number of things which need to be cleaned up / tweaked (fear
not, I will follow up with my questions and conerns), I recommend that
you get this tree by doing the following:
1) Start with a clean copy of 'linux-2.4'.  You can get this from
bk://linux.bkbits.net/linux-2.4.
2) Copy linux-2.4 to linux-2.4-mpc5xxx (or whatever) and then do:
2a) cd linux-2.4-mpc5xxx
2b) bk parent bk://ppc.bkbits.net/linux-2.4-mpc5xxx
2c) bk pull -q

What I plan on doing, and I'll let people know when this happens is to
nuke this tree and start over, once things get fixed, so we can check
this in, in an incremental manner and split out things that need to be
run past lkml first for sanity's sake (such as exporting 2 more
functions from drivers/ide/ide.c.  It should be quickly accepted, but
nonetheless).  So what this means is DO NOT TRACK OR IMPORT THIS TREE
INTO SOMETHING ELSE.  THIS TREE EXISTS ONLY SO THAT WE CAN GET THE CODE
INTO SHAPE FOR MARCELO AND CHECK IT IN AS SUCH AND THEN DELETE THIS
PARTICULAR TREE.

For fixing things either in this tree or adding new features, or
whatever, a plain old GNU-style patch is probably best for now.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
