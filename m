Message-ID: <004301c01712$24e03ee0$0a00010a@paoloweb>
From: "Paolo Scaffardi" <arsenio@tin.it>
To: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: HARDHAT 1.2 -> libc_nonshared.a not found by LD!
Date: Tue, 5 Sep 2000 10:20:22 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I installed HardHat 1.2 on my i386 Linux box to cross-compiling for my
mpc823 fads board on the previous working hardhat version (Journeyman). I
had many projects and packages configured to cross-compile. I tried to
rebuild them with the new toolkit but i experienced one big problem that i
cannot resolve by myself.

While trying to configure and compile GGI, i got this error from the linker
(/opt/hardhat/devkit/ppc/8xx/powerpc-hardhat-linux/bin/ld):

cannot find /lib/libc_nonshared.a

It seems that the linker looks for it in the host /lib instead of target
/lib (under /opt/hardhat/devkit/8xx/powerpc-hardhat-linux/lib).

How can resolve this?

I spent one day to indagate on this... :-((

Bye,
Paolo


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
