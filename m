Message-Id: <200001281007.LAA30470@denx.local.net>
To: "Linux PPC Embedded" <linuxppc-embedded@lists.linuxppc.org>,
        "Linux PPC Dev" <linuxppc-dev@lists.linuxppc.org>,
        greyham@research.canon.com.au (Graham Stoney)
Subject: Re: [ANNOUNCE] Update: MPC8xx Cross Development Tools
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 14 Jan 2000 00:34:01 +0100."
Date: Fri, 28 Jan 2000 11:07:49 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I've put an update for my scripts to build the PPC Cross Development
Kit for the MPC8xx CPUs on

	ftp://ftp.denx.de/pub/LinuxPPC/usr/src/CDK.tar.gz

The most significant change is taht the support for kernel modules is
now included by default.

The other modifications are mostly cosmetic; I did some  clean-up  so
that "ENVIRONMENT" is now really the only file you need to modify for
re-building  the  toos  for  a  different  directory  layout  or with
different versions of the included tools.

I also added some documentation:

	ftp://ftp.denx.de/pub/LinuxPPC/usr/src/README

This file is a copy of the README included with the CD I make for the
TQM8xxL modules; for re-building the cross tools see section 5.


Not included in this tarball are the original source packages that  I
used;  to  make  sure  everybody has the same starting point here the
list of URL where I got the sources from:

ftp://ftp.valinux.com/pub/support/hjl/binutils/binutils-2.9.5.0.22.tar.bz2
ftp://ftp.sunet.se/pub/gnu/egcs/releases/gcc-2.95.2/gcc-core-2.95.2.tar.bz2
ftp://ftp.sunet.se/pub/gnu/egcs/releases/gcc-2.95.2/gcc-2.95.2.tar.bz2
ftp://ftp.sunet.se/pub/gnu/glibc/glibc-2.1.2.tar.gz
ftp://ftp.gwdg.de/pub/linux/glibc/2.1.2/glibc-crypt-2.1.2.tar.gz
ftp://ftp.sunet.se/pub/gnu/glibc/glibc-linuxthreads-2.1.2.tar.gz
ftp://linuxppc.cs.nmt.edu/pub/mirror/PPC/embedded/mpc8xx-2.2.13.tgz
	(renamed to linux-2.2.13.tar.gz)

ALL type of feedback is welcome,  especially  all  contributions  for
improvement.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
SW engineering is a race between programmers trying  to  make  better
idiot-proof programs and the universe producing greater idiots.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
