Message-ID: <3A2FC5E0.75B9D05B@drea.dnd.ca>
Date: Thu, 07 Dec 2000 13:16:28 -0400
From: Gavin Hemphill <hemphill@drea.dnd.ca>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: mprotect and SMP
References: <3A2E643E.6EBA2012@drea.dnd.ca> <19341031152400.31248@192.168.1.10>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have just tried the program with the latest bk 2_2 tree (pulled four
hours ago) on both the quad 750 and quad 7400.  It still fails.  I also
built the kernel with the L2 caches disabled and that fails as well.
The same kernel built uni-processor passes on both boards.  I had
thought it might be a cacheing issue, but if it is, it's got to be level
1 cache.  I'm still at a loss as to where to start looking for the
problem.  All I can say is help!

I'll package up gemini specific patches to let the 2_2 tree boot
sometime this weekend and forward them.
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
