From: Benjamin Herrenschmidt <bh40@calva.net>
To: Gavin Hemphill <hemphill@drea.dnd.ca>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: mprotect and SMP
Date: Wed, 6 Dec 2000 22:52:16 +0100
Message-Id: <19341031152400.31248@192.168.1.10>
In-Reply-To: <3A2E643E.6EBA2012@drea.dnd.ca>
References: <3A2E643E.6EBA2012@drea.dnd.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>(2.2.18-pre11) which uses the mprotect call to lock pages between the
>threads.  If I run the test program on this machine in SMP mode, it
>fails (threads tromp on their shared memory locations).  If I run in
>uni-processor mode however it works fine.  It also works fine on a dual
>processor pentium using a similar version of the kernel.  The question
>is... Has anyone seen this sort of behavior and are there any suggested
>places to start looking to fix it?  I took a look at the gemini specific
>files to see if there were any obvious missing eieio or sync
>instructions and so far haven't seen any, but I don't have the
>experience to know where else I should be looking.

Can you get the latest bitkeeper _2_2 tree or paulus latest rsync
tree and see if it still happens ?

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
