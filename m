Message-Id: <199911202140.WAA00815@appel.flower>
To: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
cc: linuxppc-dev@lists.linuxppc.org, dorland@lords.com, hollis+@andrew.cmu.edu
Subject: Re: Floppy problems 
In-reply-to: Your message of "Sat, 20 Nov 1999 10:52:37 PST."
             <Pine.LNX.3.96.991120105010.4129B-100000@deepspace.mklinux.org>
Date: Sat, 20 Nov 1999 22:40:58 +0100
From: Jan Nieuwenhuizen <janneke@gnu.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Saturday, 20 November 1999, "David A. Gatwood" writes:

> > > It is very weird. Again, other G3 users, does your floppy drive work?
> > 
> > No, mine doesn't work either.  I've reported and asked several times here,
> > but never got replies (other than: use gdb.. duh)
> 
> Something to check: look inside and see what the drive used is.  As far as
> I know, it should be either the standard Panasonic or the mostly standard
> Mitsubishi, but if it's a different drive, there could be some issues.

Yes, it's a Mitsubishi.

> And again, you should try MkLinux and see if it can handle the drive so
> that if so, the LinuxPPC coders can use that as a working reference to see
> what's wrong in the drivers.  (Of course, if MkLinux doesn't work, there's
> probably a hardware bug, since we use Copland's floppy driver.)

Ok, I checked: it works fine under Mklinux. (must address as /dev/fd0H1440,
because fd0 is 'no such device'.  Also, X didn't work anymore, but these
maybe mk-newbe problems.)

On another unrelated note: while I was at it I tried to mount a
home-brew CD-ROM under Mklinux.  It failed gracefully, printing these
errors:

    <lev 2> block_read_reply: rdev 16:00 rsector 0x40 size 0x400 err=0x9c4=2500 "unknown error code" 
    isofs_read_super: bread failed, dev 16:00 iso_blknum 16 block 32 
    block_ioctl(dev=16:00, cmd=0x20001260) not implemented 

Trying to mount this particular CD-ROM under linuxppc-Q3's 2.2.6 or 2.3.23
freezes the kernel (not pingable, nothing in logs).

Jan.

-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien/      | http://www.lilypond.org/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
