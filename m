To: linuxppc-dev@lists.linuxppc.org
Cc: debian-powerpc@lists.debian.org
Subject: SMP kernels on single processor machines
Reply-To: Jens Schmalzing <j.s@lmu.de>
From: Jens Schmalzing <j.s@lmu.de>
Date: 20 May 2004 12:58:34 +0200
Message-ID: <hhad03tlet.fsf@alsvidh.mathematik.uni-muenchen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

putting together another release of the Debian kernel image packages,
I am wondering whether we could get rid of half the packages by simply
not supplying single processor flavours - after all, SMP kernels run
fine on single processor machines.  I have repeatedly been told,
however, that this bears a considerable performance hit on some
hardware.  Can anybody confirm or deny this?  Even small hints would
be appreciated.

Regards, Jens.

--
J'qbpbe, le m'en fquz pe j'qbpbe!
Le veux aimeb et mqubib panz je pézqbpbe je djuz tqtaj!

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
