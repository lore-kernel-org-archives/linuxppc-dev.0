Date: Sat, 20 Nov 1999 13:52:19 -0800 (PST)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: Jan Nieuwenhuizen <janneke@gnu.org>
cc: linuxppc-dev@lists.linuxppc.org, dorland@lords.com, hollis+@andrew.cmu.edu
Subject: Re: Floppy problems 
In-Reply-To: <199911202140.WAA00815@appel.flower>
Message-ID: <Pine.LNX.3.96.991120134711.4129J-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 20 Nov 1999, Jan Nieuwenhuizen wrote:

> > Something to check: look inside and see what the drive used is.  As far as
> > I know, it should be either the standard Panasonic or the mostly standard
> > Mitsubishi, but if it's a different drive, there could be some issues.
> 
> Yes, it's a Mitsubishi.

Hmm.  That's the same drive used in the majority of PCI PowerMacs.  Odd.


> > And again, you should try MkLinux and see if it can handle the drive so
> > that if so, the LinuxPPC coders can use that as a working reference to see
> > what's wrong in the drivers.  (Of course, if MkLinux doesn't work, there's
> > probably a hardware bug, since we use Copland's floppy driver.)
> 
> Ok, I checked: it works fine under Mklinux. (must address as /dev/fd0H1440,
> because fd0 is 'no such device'.

Yeah.  I still haven't gotten around to changing that.  Mach takes control
of device size handling, so all of the /dev/fd0H*'s work the same except
fd0, which for some reason, they didn't attach to the driver....


> Also, X didn't work anymore, but these
> maybe mk-newbe problems.)

Heheh.  Let me guess.  Just hangs?  Should be fixed in the latest vmlinux
server sources, but nobody's built since then....  (mental note, build
kernel/server pair tonight.)


> On another unrelated note: while I was at it I tried to mount a
> home-brew CD-ROM under Mklinux.  It failed gracefully, printing these
> errors:
> 
>     <lev 2> block_read_reply: rdev 16:00 rsector 0x40 size 0x400 err=0x9c4=2500 "unknown error code" 
>     isofs_read_super: bread failed, dev 16:00 iso_blknum 16 block 32 
>     block_ioctl(dev=16:00, cmd=0x20001260) not implemented 
> 
> Trying to mount this particular CD-ROM under linuxppc-Q3's 2.2.6 or 2.3.23
> freezes the kernel (not pingable, nothing in logs).

Eek.  :-)


David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
