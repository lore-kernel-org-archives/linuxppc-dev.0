Date: Thu, 29 Jul 1999 15:48:59 +1000
Message-Id: <199907290548.PAA02760@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: drow@false.org
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <19990729013842.A1209@them.org> (message from Daniel Jacobowitz
	on Thu, 29 Jul 1999 01:38:42 -0400)
Subject: Re: Vger broken w.r.t. gdb
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <19990728222617.A636@them.org> <199907290400.OAA02618@tango.anu.edu.au> <19990729013842.A1209@them.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Daniel Jacobowitz <drow@false.org> wrote:

> So my question is, what is at 0x3000c1a8?  It would appear, if I am not
> misreading binfmt_elf.c, to be the program itself in its original
> mmap'd location.  I'm not at all confident of that conclusion, though.

Cat /proc/<pid>/maps while you have the ls process stopped at an
appropriate point.

> So regs->msr is actually from SRR1 of the running program?  Does it
> generally get stuffed back into the MSR when that task is running?

Yep, but the high bits get ignored.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
