Subject: RE: ptrace Problem
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 16 Jul 2003 15:46:30 -0400
Message-ID: <AB5AF73EAF23304EA1B932174137CED70303B1@m5tmail.m5t.com>
From: "Jean-Denis Boyer" <jdboyer@m5t.com>
To: "Kent Borg" <kentborg@borg.org>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kent,

> It lists a series of numbers ranging from 2.0 to 2.2.2.

Actually, there are obviously many ways to know the glibc version. When running on the embedded platform, you can issue a:
  ldd --version
But my "preferred" way is by looking at the soft link "libc.so.6" and confirm it matches on both the embedded system being debugged, and the system where gdb runs.

An idea: Does running native gdb (on the embedded system) debug correctly?

I'm currently using the following setup, which runs correctly both natively and in cross-debugging:
  MPC8250 (603e core, Hip4)
  Kernel 2.4.21
  binutils 2.13.90.0.18 (from ftp://ftp.kernel.org)
  gcc 3.2.3
  glibc 2.3.2 (with pthread)
  gdb 5.3
(Note that everything here was cross-compiled)

This version of binutils is the one recommended for powerpc-linux
(see http://gcc.gnu.org/install/specific.html#powerpc-*-linux-gnu*)

Regards,
--------------------------------------------
 Jean-Denis Boyer, Eng.
 Software Designer
 M5T Centre d'Excellence en Télécom Inc.
 4283 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-3972 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
