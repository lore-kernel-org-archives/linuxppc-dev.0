Date: Fri, 16 Feb 2001 21:10:08 +0000
Subject: Re: ltrace for ppc
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Karim Yaghmour <karym@opersys.com>
Cc: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010216210927.A9F26DBA2E@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> If you're interested in ltrace, you may want to take a look at the
> Linux trace toolkit (http://www.opersys.com/LTT). It runs fine
> on PPC too.

I'm *very* interested in any toolkit that can provide point-to-point
_timing_ of system calls, IRQ handling, system usage. latency etc. etc. (a
la TIMEPEGS or Andrew Morton's amlat on x86).

what do we have (existing) on PPC?

I did an IRQ latency thing on 2.2.x and Cort has proposed using RTlinux to
make IRQ measurements (well, I think he's done it, actually)...  that will
give headlines - but not tell us which drivers/functions are the rouges.

I was considering doing a port of Andrew Morton's stuff - but got stuck when
I tried to run with HZ=1024 - it trashed adb... and I haven't got back to it
yet.

ciao,
Iain

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
