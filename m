Date: Sat, 20 Nov 1999 15:37:45 -0800 (PST)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: Jan Nieuwenhuizen <janneke@gnu.org>
cc: linuxppc-dev@lists.linuxppc.org, dorland@lords.com, hollis+@andrew.cmu.edu
Subject: Re: Floppy problems 
In-Reply-To: <199911202322.AAA01306@appel.flower>
Message-ID: <Pine.LNX.3.96.991120153200.568B-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 21 Nov 1999, Jan Nieuwenhuizen wrote:

> On Saturday, 20 November 1999, "David A. Gatwood" writes:
> 
> > Hmm.  That's the same drive used in the majority of PCI PowerMacs.  Odd.
> 
> Thanks for answering so quickly.  Is there anything one/I can do
> except for just looking at the code?
> (did you see my 'bug report'?  all seems to go well, until close (),
>  which just blocks.  I'm at loss, there).

That's the strangest thing I've ever seen, that's for sure.  I have no
idea where to look to track that down.  You might run gdb on the program
and trace your way into the call and see if you can come up with anything
useful that way.  Dunno.  If close() is really failing, I'd guess it's
probably a buffer cache problem.


> > Heheh.  Let me guess.  Just hangs?  Should be fixed in the latest vmlinux
> 
> Yep.
> 
> > server sources, but nobody's built since then....  (mental note, build
> > kernel/server pair tonight.)
> 
> Could you drop me an url?

I'll start building GENERIC #09 alpha kernels shortly, ramping up for
MkLinux R1.  Probably be on ftp://globegate.utm.edu/pub/MkLinux/alpha.
The GENERIC #08 alphas are all there right now, and they'll be moving into
a separate directory, or maybe just ripped out and archived.  I haven't
decided yet.


> > > Trying to mount this particular CD-ROM under linuxppc-Q3's 2.2.6 or 2.3.23
> > > freezes the kernel (not pingable, nothing in logs).
> > 
> > Eek.  :-)
> 
> You take the words right out of my mouth :-)


Later,
David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
