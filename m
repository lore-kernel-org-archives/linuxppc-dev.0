Message-ID: <398C263D.68F94160@student.ethz.ch>
Date: Sat, 05 Aug 2000 16:35:41 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kind of success! (r128 on PPC (Re: LinuxPPC X Server))
References: <398AF755.E10D0C56@student.ethz.ch> <20000804175047.21209@mailhost.mipsys.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

[about aty128fb setting the RAMDAC to 15 bit for depth 16]

> > fbset -i reveals that it does.
> >
> > Is anyone actively maintaining aty128fb or should I try to fix that as
> > well as the panning? Looking at the X r128 driver, it shouldn't be too
> > hard.
>
> Brad Douglas, but he doesn't have a PPC machine.

Okay, I'll contact him, thanks.

My priority is to get 16 bit working, panning isn't so important for me
because only one mode works on the Pismo anyway.

Unfortunately, I don't have time over the weekend, but I'm cooking up a patch
X 4.0.1 -> DRI CVS which I'm sending to the people involved.


Michel


--
I'm so hungry, I could almost eat health food.
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
