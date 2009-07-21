Return-Path: <david.jander@protonic.nl>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E1CECB70BA
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Jul 2009 19:47:46 +1000 (EST)
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 6708DDDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2009 19:47:46 +1000 (EST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-dev@ozlabs.org
Subject: Best hardware platform for native compiling...
Date: Tue, 21 Jul 2009 11:16:52 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200907211116.52963.david.jander@protonic.nl>
Cc: Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi all,

This might sound as a stupid question (and maybe sligtly off-topic), but I 
have not found an (easy) answer and I suspect many on this list will have a 
good suggestion to make:

We are developing (and maintaining) different embedded linux systems based on 
different PowerPC processors. From small MPC852T with little RAM and Flash, 
up to 400MHz MPC5200- and MPC5121e based systems that resemble more a PC or 
netbook than an embedded system in terms of RAM and storage.

For smaller systems we use a customized ELDK-based OS and cross-compile almost 
everything on a PC.

For bigger systems we often run a debian-derived OS like Ubuntu, and many 
pieces are compiled natively on the target... just because it is easy and 
quick to do, and cross-compiling certain packages can be a real pain.
But, a 400 MHz e300 core is not really fast for compiling, so I have been 
considering buying some sort of PowerPC-based system with a faster processor, 
just as a "build-server" (a G5 would do wonders I guess).

It seems like the only real option is one of the smaller IBM Power servers, 
but that seems overkill to me. We also don't feel like buying some old 
second-hand Apple gear.

Is there any other available and affordable platform that can be used to run 
linux and compile software natively for 32-bit PowerPC?

Any suggestion is welcome!

Best regards,

P.S.: I am writing this while running "dpkg-buildpackage -rfakeroot" on the 
package "xserver-xfbdev" from ubuntu 9.04 on a MPC5121e.... it will take 40 
minutes ;-)

-- 
David Jander
Protonic Holland.
