Message-ID: <3A2F82B3.46C4C2E0@drea.dnd.ca>
Date: Thu, 07 Dec 2000 08:29:38 -0400
From: Gavin Hemphill <hemphill@drea.dnd.ca>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: mprotect and SMP
References: <3A2E643E.6EBA2012@drea.dnd.ca> <19341031152400.31248@192.168.1.10>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This problem has existed since the earliest kernels I've had for the
gemini (about 2.2.13).

I've got read access to the bk tree now, the problem is that it doesn't
boot when configured for the gemini, I'm going to look through the
gemini specific diffs and try and get the 2_2 tree running, but from
what I've seen in the larger set of diff's there's no modifications that
seem to apply to the mprotect problem.  Just out of curiosity, if I do
get the gemini configuration running who do I send the changes to so
that they make it back into the tree.
	Gavin

Benjamin Herrenschmidt wrote:
>
> >(2.2.18-pre11) which uses the mprotect call to lock pages between the
> >threads.  If I run the test program on this machine in SMP mode, it
> >fails (threads tromp on their shared memory locations).  If I run in
> >uni-processor mode however it works fine.  It also works fine on a dual
> >processor pentium using a similar version of the kernel.  The question
> >is... Has anyone seen this sort of behavior and are there any suggested
> >places to start looking to fix it?  I took a look at the gemini specific
> >files to see if there were any obvious missing eieio or sync
> >instructions and so far haven't seen any, but I don't have the
> >experience to know where else I should be looking.
>
> Can you get the latest bitkeeper _2_2 tree or paulus latest rsync
> tree and see if it still happens ?
>
> Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
