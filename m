Message-ID: <3890AA00.36DE0DCD@erols.com>
Date: Thu, 27 Jan 2000 15:26:40 -0500
From: Nelson Abramson <pogtal@erols.com>
MIME-Version: 1.0
To: Kevin Puetz <puetzk@iastate.edu>
CC: linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org
Subject: Re: Mozilla M13 Release Build Available
References: <E12DusK-0007We-00@puetz.penguinpowered.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kevin Puetz wrote:

> Hello all, and good news!

Excellent news :-)

> Linux/PowerPC is now a working mozilla platform, thanks to the efforts of
> Franz Sirl, waterson, and others. I have a release build available at
> <http://www.public.iastate.edu/~puetzk/mozilla-ppc-unknown-linux-gnu-M13.tar.gz
> > This shouls be appearing on mozilla.org soon, but first I need some testers
> to verify that it works correctly on LinuxPPC and other distributions (it was
> built on a Debian/PPC system). After first installing it, it needs to be run
> as root first so that it can create its component.reg file - after that it
> should be fine for all users.

When I try and run "./mozilla", it starts, and then stops w/ the
error: "./mozilla-bin: error in loading shared libraries: libelf.so.0: cannot open
shared object file: No such file or directory "  Obviously this (or atleast seems
like) a dependency error.  I have libelf installed (I rpmed a new copy jik), but
the file definately does NOT exist on my hard drive.  What package should this
file be part of..?  I checked libelf, it doesn't supply it...

TIA
--Nelson Abramson

--

It is not enough, as the communist systems have assumed, merely to provide
people with food, shelter, and clothing ... [without freedom and liberty]
we are only half human; we are like animals who are content just to satisfy
their physical needs.

--The Dalai Lama, Global Communiy and the Need for Universal Responsibility


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
