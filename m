Message-ID: <3987E7C4.6574A103@relog.ch>
Date: Wed, 02 Aug 2000 11:20:04 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: Daniel Jacobowitz <drow@false.org>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC X Server
References: <39853D27.8F4F5500@relog.ch>
	 <Pine.LNX.4.21.0008011508360.4803-100000@idd-01.imbc.gr> <20000801140642.B24586@drow.them.org>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Daniel Jacobowitz wrote:

> > Also note that the DRI drivers don't get build by default in PPC
> > you have to #define BuildXF86DRI YES in xf config files *AND*
> > patch xc/lib/GL/mesa/src/drv/Imakefile to enable the dri drivers
> > to build under ppc.
> >
> > Unfortunately i don't have an r128 card so i can't do anything here :(
>
> What sort of patch do we need to that Imakefile?  I couldn't figure out
> what to do.

What I did is I went directly to xc/lib/GL/mesa/src/drv/r128, created the
Makefile manually (go to any other directory and do make Makefile to get the
idea) and then did make depend includes all . That got me
modules/dri/r128_dri.so .


> I turned on BuildXF86DRI in linux.cf in an attempt to build libOSmesa, and
> failed.

Is libOSmesa needed for DRI?


Michel


--
Death is just Nature's way of saying, "Hey! You're not alive anymore!"
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
