Content-Type: text/plain;
  charset="iso-8859-1"
From: David Given <dg@tao-group.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: iMac / ATI Rage 128 Pro TR
Date: Fri, 14 Dec 2001 13:00:09 +0000
MIME-Version: 1.0
Message-Id: <E16Erwf-0000bT-00@rhodium.tao.co.uk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


We've just replaced our elderly PowerMac 8200/120 with a nice iMac. Ten times
the memory, five times the processor speed, twenty times the disk space, and
a tiny fraction of the grief.

Unfortunately, it uses a rather odd video card, a Rage Pro TR (id 1002.5452).
The kernel does not support this, so I'm stuck with the Open Firmware driver
at 800x600x8. I've tried modifying the kernel so that it's treated as any
other Rage Pro, but the kernel seg faults.

Now, the reason why I'm posting here is that the Debian kernel I originally
booted from *did* support it. It claimed to be 2.2.0-pmac. Does anyone know
if an equivalent patch is available for a 2.4-series kernel (which we have to
use for development reasons)? Alternatively, is there anywhere I haven't
found yet that I should be looking?

(Oh, yes. And does anyone know how to work out what revision an iMac is? It's
dark blue with a CDROM, if that's any help.)

--
David Given
dg@tao-group.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
