Message-Id: <199911202322.AAA01306@appel.flower>
To: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
cc: linuxppc-dev@lists.linuxppc.org, dorland@lords.com, hollis+@andrew.cmu.edu
Subject: Re: Floppy problems 
In-reply-to: Your message of "Sat, 20 Nov 1999 13:52:19 PST."
             <Pine.LNX.3.96.991120134711.4129J-100000@deepspace.mklinux.org>
Date: Sun, 21 Nov 1999 00:22:43 +0100
From: Jan Nieuwenhuizen <janneke@gnu.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Saturday, 20 November 1999, "David A. Gatwood" writes:

> Hmm.  That's the same drive used in the majority of PCI PowerMacs.  Odd.

Thanks for answering so quickly.  Is there anything one/I can do
except for just looking at the code?
(did you see my 'bug report'?  all seems to go well, until close (),
 which just blocks.  I'm at loss, there).
 
> Yeah.  I still haven't gotten around to changing that.  Mach takes control
> of device size handling, so all of the /dev/fd0H*'s work the same except
> fd0, which for some reason, they didn't attach to the driver....

Ok.

> Heheh.  Let me guess.  Just hangs?  Should be fixed in the latest vmlinux

Yep.

> server sources, but nobody's built since then....  (mental note, build
> kernel/server pair tonight.)

Could you drop me an url?

> > Trying to mount this particular CD-ROM under linuxppc-Q3's 2.2.6 or 2.3.23
> > freezes the kernel (not pingable, nothing in logs).
> 
> Eek.  :-)

You take the words right out of my mouth :-)

Jan.

-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien/      | http://www.lilypond.org/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
