Date: Sat, 20 Nov 1999 10:52:37 -0800 (PST)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: Jan Nieuwenhuizen <janneke@gnu.org>
cc: linuxppc-dev@lists.linuxppc.org, dorland@lords.com, hollis+@andrew.cmu.edu
Subject: Re: Floppy problems
In-Reply-To: <199911201327.OAA17266@appel.flower>
Message-ID: <Pine.LNX.3.96.991120105010.4129B-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 20 Nov 1999, Jan Nieuwenhuizen wrote:

> On Sat, 20 Nov 1999 David A. Gatwood writes:
> 
> > It is very weird. Again, other G3 users, does your floppy drive work?
> 
> No, mine doesn't work either.  I've reported and asked several times here,
> but never got replies (other than: use gdb.. duh)

Something to check: look inside and see what the drive used is.  As far as
I know, it should be either the standard Panasonic or the mostly standard
Mitsubishi, but if it's a different drive, there could be some issues.
And again, you should try MkLinux and see if it can handle the drive so
that if so, the LinuxPPC coders can use that as a working reference to see
what's wrong in the drivers.  (Of course, if MkLinux doesn't work, there's
probably a hardware bug, since we use Copland's floppy driver.)


David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
