Message-ID: <3A22BB86.92419741@nexus-tech.net>
Date: Mon, 27 Nov 2000 14:52:39 -0500
From: Kyle Harris <kharris@nexus-tech.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: fb on mpc823
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm trying to get a framebuffer device running on an mpc823 board
(tqm823). I'm a little confused (not unusual :). Which device should
/dev/fb0 be? fbmem.c opens a device using major 29. But lcd823.c also
opens a device using major 62. Do I even need all of the standard fb
stuff? Or can I simply insmod lcd823.o (built to run as a module) and
get things to work?

Thanks for any help, Kyle.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
