Date: Tue, 24 Aug 2004 09:25:35 +0200
From: Marc Leeman <marc.leeman@barco.com>
To: Patrick Huesmann <tricknology@gmx.de>
Cc: linuxppc-embedded@lists.linuxppc.org, samlinuxppc@yahoo.com.cn
Subject: Re: How to port ppc-linux to new custom boards? (virtexII)
Message-ID: <20040824072535.GN15035@smtp.barco.com>
Reply-To: Marc Leeman <marc.leeman@barco.com>
References: <18802.1093328823@www32.gmx.net>
Mime-Version: 1.0
In-Reply-To: <18802.1093328823@www32.gmx.net>
Content-Type: text/plain; charset=iso-8859-15
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > Where did you download the Montavista 2_4_devel?

If size is an issue for your distrib, have a look at uclibc [1],
busybox [2] (buildroot [3] and ptxdist [4] for configuring your final
system). When compared to MVL (configured with devrocket), you'll end
up with a much cleaner and smaller system (about half the size).

buildroot is a Makefile based system to setup your cross compilation
environment and creates your target FS.

ptxdist is a kconfig based all but the kitchen sinck approach, haven't
really checked it out but it looks really impressive, supports uclibc
and busybox (IIRC).

A very good general development environment can be found in ELDK [5].

Zhe bootloader is of course das U-Boot [6].

Unless you have very specific requirements, the normal kernel is as good
as a branched version:
$ make ARCH=ppc CROSS_COMPILE=powerpc-linux-
$ make ARCH=ppc CROSS_COMPILE=ppc_82xx-

If you are using GNU/Debian, there is a nice tutorial for creating the
cross packages [7].

Finally, do not overestimate the commercial support, to my experience;
the collaborative mailing lists are often as good if not better to point
you in the correct direction due to the diverse expertises of the ppl on
the list.

[1] http://www.uclibc.org/
[2] http://www.busybox.net/
[3] http://www.pengutronix.de/software/ptxdist_en.html
[4] http://uclibc.org/cgi-bin/cvsweb/buildroot/
[5] http://www.denx.de/ELDK/
[6] http://u-boot.sourceforge.net/
[7] http://people.debian.org/~debacle/cross.html

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
