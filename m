Date: Fri, 30 Jul 1999 02:03:24 -0400
From: Daniel Jacobowitz <drow@false.org>
To: Paul.Mackerras@cs.anu.edu.au
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Vger broken w.r.t. gdb
Message-ID: <19990730020323.A798@them.org>
References: <19990728222617.A636@them.org> <199907290400.OAA02618@tango.anu.edu.au> <19990729013842.A1209@them.org> <199907290548.PAA02760@tango.anu.edu.au> <19990730011819.A364@them.org> <199907300524.PAA03967@tango.anu.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199907300524.PAA03967@tango.anu.edu.au>; from Paul Mackerras on Fri, Jul 30, 1999 at 03:24:26PM +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jul 30, 1999 at 03:24:26PM +1000, Paul Mackerras wrote:
> Daniel Jacobowitz <drow@false.org> wrote:
> 
> > Now I'm really confused.
> > 
> > >From my readings it appears that we should only reach this point if a
> > trap instruction was encountered.  But from what I can see no trap
> > instruction exists at that address.  At
> 
> A common thing that gdb does is to put trap instructions into the
> memory image of a process being debugged.  It sounds to me as though,
> with all the page cache and memory management changes that have gone
> on in 2.3, we now have the undesirable situation that a trap
> instruction put in by gdb hasn't stayed confined to the process being
> debugged but has leaked into the copy of the page that is being used
> by other processes.

That makes sense, but wouldn't it have shown up in the core dump if
that were the case?



Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
