Message-ID: <BE1C564723B3D21191FD0000F840E39801D814D4@rfcmx2.rfc.comm.harris.com>
From: "Brown, David (dbrown03)" <DBrown03@harris.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: kgdb and GetDebugChar/PutDebugChar
Date: Tue, 25 Apr 2000 17:33:13 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Re: http://lists.linuxppc.org/listarcs/linuxppc-dev/200003/msg00097.html

When KGDB is enabled, no GetDebugChar/PutDebugChar functions exist.
The answer given in the message above was that you have to write your own,
based on the hardware.

Surely, someone here has done that for the ppc8xx, using maybe SMC2?
Shouldn't such functions be in 8xx_io/uart.c?
If SMC2 is used for KGDB, I assume it shouldn't be included in rs_table?
--
Dave Brown <dbrown03@harris.com>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
