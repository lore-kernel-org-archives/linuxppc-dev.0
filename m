Message-ID: <37B0A453.2B7D3DE6@wanadoo.fr>
Date: Wed, 11 Aug 1999 00:14:43 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Tom Rini <trini@disparity.net>
CC: Hollis R Blanchard <hollis+@andrew.cmu.edu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: cvs.on.openprojects.net status?
References: <Pine.BSF.3.96.990810162521.305H-100000@silver.teardrop.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:
> 
> On Tue, 10 Aug 1999, Martin Costabel wrote:
> 
> > The cvs server is alive again now, and the linux_2_2 branch has moved to
> > 2.2.11 with a great many updates.
> 
> The problem isn't w/ vger, but the cvs.on.openprojects.net mirror it would
> seem.  I have had it complain that user anonymous doens't exist, and
> traceroutes to the machine die, and work fine other times.  Anyhow..
> 
> > The kernel doesn't compile, though. There is a new line
> >
> >   EXPORT_SYMBOL(init_task_union);
> >
> > in kernel/ksyms.c which conflicts with the same line in
> > arch/ppc/kernel/ppc_ksyms.c. One of the two has to go.
> 
> Maybe you snagged it before 2.2.11 final and this commit from Cort?
> 
> > CVSROOT:      /vger/u4/cvs
> > Module name:  linux
> > Branch:       linux_2_2
> > Changes by:   cort@vger.rutgers.edu   99/08/09 16:40:05
> >
> > Modified files:
> >       arch/ppc/kernel: process.c ppc_ksyms.c
> >
> > Log message:
> >       init_task_union changes

As of right now (00:05 WST = 18:05 EDT), this commit has not yet arrived
on the cvs.on.openprojects.net mirror. The last entry in the log file
for arch/ppc/kernel/ppc_ksyms.c in the linux_2_2 branch dates from 2
weeks ago: 

  revision 1.52.2.3
  date: 1999/07/26 06:10:25;  author: paulus;  state: Exp;  lines: +2 -0
  add __lshrdi3 (thanks to Alain Richard)

So I'll just be patient. Tomorrow I won't have any time for linux
anyway. Have to watch the solar eclipse.

--
Martin

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
