Message-ID: <396341CE.71DDB938@relog.ch>
Date: Wed, 05 Jul 2000 16:10:22 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: Gwyn Judd <b.judd@xtra.co.nz>
CC: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: seemingly random lock-up with kernel 2.2.17p7
References: <20000706013650.A2546@thislove.dyndns.org>
	 <Pine.SGI.4.21.0007050845550.10655-100000@rainbow.uchicago.edu> <20000706020342.B986@thislove.dyndns.org>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gwyn Judd wrote:
>
> On Wed, Jul 05, 2000 at 08:51:09AM -0500, me@johngrimes.com wrote:
> > Gwyn,
> >       Might be related or might not but I have recently started having
> > troubles too with random locks.
> >       Now I am running 2.2.15 (but this started happening soon after the
> > upgrade)
> >       Now my error is not directly with the kernel though.  If I am in
> > the console it has never happened but only if I am in X.  In fact its X
> > that crashes but as no keys work it doesn't matter.  Now I always have
> > xmms open when I crash but it also might be a screensaver problem as it
> > always happens when the screensaver is one (which is the majority of the
> > time though).
> >       Does this sound similar?
> >       Do you have an ati rage 128gl card by chance?
> >       John
>
> This all sounds quite familiar. The lockups have happened with both xmms
> and mpg123. I have no idea if it is a full system lock or just X since I
> have no remote machine to ping it with, all I am able to do is force
> reboot. It happened also with 2.2.15 I think as well as 2.2.16

What versions of X are you using? Someone reported lockups with the 4.0 r128
driver a long time ago and someone else suggested it might be bad interaction
between the graphics and sound devices.


Just two more of my cents,

Michel


--
True programmers never die, they just branch to an odd address.
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
