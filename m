Message-ID: <21A8AE56EBB6D411A4520060973D360179DDD6@pepintercom.pep.de>
From: Claus Gindhart <Claus.Gindhart@pep.de>
To: "'Leiying Du'" <ldu@solectek.com>,
	"'LinuxPPC-Embedded'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Compile the GDB
Date: Fri, 19 Apr 2002 08:04:37 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Did You execute configure ?
I did this some time ago, and as far is i remember bfd.h is created with
configure.
Choose configure --host=[your host] --target=powerpc-linux-gnu.

Compiling gdb should work then.

The next problem will arise, when trying to compile gdbserver. It requires,
that --host and --target are configured to the same value. But i did not
manage to do it without manually editing some header-files


-----Original Message-----
From: Leiying Du [mailto:ldu@solectek.com]
Sent: Thursday, April 18, 2002 8:11 PM
To: 'LinuxPPC-Embedded'
Subject: Compile the GDB



Does anyone have compiled the GDB5.x with the Hardhat ppc_8xx-gcc(version
2.95.2)? I always get some .h files missing error, like the bfd.h.
Thanks,

Leiying


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
