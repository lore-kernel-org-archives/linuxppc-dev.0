Date: Sun, 21 May 2000 17:01:22 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Alain Birtz <abz@videotron.ca>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Where is jiffies (lib)?
In-Reply-To: <3927DB6C.CCD39B7A@videotron.ca>
Message-ID: <Pine.LNX.4.10.10005211658100.2059-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> jiffies is declared in /linux/sched.h as extern unsigned long volatile.
> But what is the libary that hold jiffies.
> I got a link error about this.

kernel/sched.c declares jiffies (and one of it's tasks is incrementing
jiffies on each timer tick). User space code should never see the bulk of
linux/sched.h anyway - what were you doing?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
