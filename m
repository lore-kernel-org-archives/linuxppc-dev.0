Date: Tue, 10 Aug 1999 16:29:03 -0400 (EDT)
From: Tom Rini <trini@disparity.net>
Reply-To: Tom Rini <trini@disparity.net>
To: Martin Costabel <costabel@wanadoo.fr>
cc: Hollis R Blanchard <hollis+@andrew.cmu.edu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: cvs.on.openprojects.net status?
In-Reply-To: <37B0068E.C8853FC3@wanadoo.fr>
Message-ID: <Pine.BSF.3.96.990810162521.305H-100000@silver.teardrop.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 10 Aug 1999, Martin Costabel wrote:

> The cvs server is alive again now, and the linux_2_2 branch has moved to
> 2.2.11 with a great many updates.

The problem isn't w/ vger, but the cvs.on.openprojects.net mirror it would
seem.  I have had it complain that user anonymous doens't exist, and
traceroutes to the machine die, and work fine other times.  Anyhow..

> The kernel doesn't compile, though. There is a new line
> 
>   EXPORT_SYMBOL(init_task_union);
> 
> in kernel/ksyms.c which conflicts with the same line in
> arch/ppc/kernel/ppc_ksyms.c. One of the two has to go.

Maybe you snagged it before 2.2.11 final and this commit from Cort?

> CVSROOT:	/vger/u4/cvs
> Module name:	linux
> Branch: 	linux_2_2
> Changes by:	cort@vger.rutgers.edu	99/08/09 16:40:05
> 
> Modified files:
> 	arch/ppc/kernel: process.c ppc_ksyms.c 
> 
> Log message:
> 	init_task_union changes
> 

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
