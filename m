To: linuxppc-dev@lists.linuxppc.org
Subject: ATI Rage 128 Mobility very slow with 2.6.6 Debian kernel
Reply-To: Jens Schmalzing <j.s@lmu.de>
From: Jens Schmalzing <j.s@lmu.de>
Date: 27 May 2004 23:53:01 +0200
Message-ID: <hhekp5ilky.fsf@theorie.physik.uni-muenchen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

a user of my Debian kernel packages reported today that his Xserver
was really slow when using the drm interface.  After a number of
tries, I have been able to reproduce the problem - the XFree86.0.log
seems to go in an endless loop logging the line

 (EE) R128(0): Idle timed out, resetting engine...

over and over again.  This does not occur with the module from the
dri-trunk, btw.

Any hints?

Regards, Jens.

--
J'qbpbe, le m'en fquz pe j'qbpbe!
Le veux aimeb et mqubib panz je pézqbpbe je djuz tqtaj!

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
