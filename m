Date: Mon, 2 Aug 1999 11:50:34 -0400
From: Daniel Jacobowitz <drow@false.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: gdb broken under linuxppc r5 tools
Message-ID: <19990802115034.A16484@them.org>
References: <990801202455.ZM22552@redrock.lan> <99080211313600.00413@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <99080211313600.00413@localhost.localdomain>; from kbhend on Mon, Aug 02, 1999 at 11:21:19AM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Aug 02, 1999 at 11:21:19AM -0400, kbhend wrote:
> 
> Hi Kevin,
> 
> > Kevin, Franz, et.al,
> > 
> > Earlier this year, Metrowerks and I signed the copyright assignments
> > required by the FSF.  Beginning August 9, I will be starting work at
> > Cygnus as a GDB engineer.  One of the things that I'll work on is a
> > merge of my patches into the current gdb mainline.  It'll be my goal
> > to get a solid, usable gdb up and running on Linux/PPC again.
> 
> Congrats!  It is good to hear from you again!  We still miss you on the LinuxPPC
> JDK porting team!  Care to rejoin?!? :-)
> 
> As for gdb, something changed seriously between Paul's 2.2.1 kernel running on
> a R4.1 build (gdb was very very stable when debugging shared libs) and Paul's
> 2.2.10 kernel running LinuxPPC R5 or YDL.

Could you possibly try booting 2.2.1 on this R5 or YDL system?  I'd
like to isolate this from kernel or userland problem.

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
