Date: Sun, 17 Jan 1999 15:29:14 -0500
From: Daniel Jacobowitz <drow@false.org>
To: Paul.Mackerras@cs.anu.edu.au
Cc: brad@pht.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: scsi hangs [drow@cs.cmu.edu: Re: CD-writers] (fwd)
Message-ID: <19990117152914.A12471@drow.res.cmu.edu>
References: <Pine.LNX.3.95.990103224624.29306A-100000@pacific.pht.com> <199901041138.WAA00533@tango.anu.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199901041138.WAA00533@tango.anu.edu.au>; from Paul Mackerras on Mon, Jan 04, 1999 at 10:38:45PM +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jan 04, 1999 at 10:38:45PM +1100, Paul Mackerras wrote:
> Brad Midgley <brad@pht.com> wrote:
> 
> > i have tried out the current vger kernel and i'd characterize it as "five
> > times" as stable. meaning i can copy 125 megabytes from a jaz on the
> > external bus to a drive on the internal bus before it crashes--with
> > 2.1.130 i could only copy about 25 megabytes before it crashed. the error
> > when it crashes is always:
> 
> Actually, I'm not sure that the vger version had the locking exactly
> right before.  The version in vger is now the same as the version
> currently in the official tree, and I am moderately confident it's OK.
> If you can reproduce it with that version, I really will have to dig
> deeper.
> 
> We will never get the sd.c patch into the official version because it
> breaks SMP machines.  I know because that's what happened on my SMP
> powermac. :-)


I don't have the exact messages, but attempting to use an external CDR
(boot drive on MESH, burner on 53c94) locks up with a bunch of illegal
sense requests.  Then it tries to reset the external bus, times out,
claims to try harder, and more or less locks up.

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|     CMU, CS class of 2002      |
|   Debian GNU/Linux Developer    __   Part-Time Systems Programmer  |
|         dan@debian.org         |  |        drow@cs.cmu.edu         |
\--------------------------------/  \--------------------------------/

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
