From: "Ron Bianco" <ronb@junction.net>
To: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Using SCSI driver sym53c8xx.c - no nvram - no symbios BIOS
Date: Tue, 1 Aug 2000 11:48:42 -0700
Message-ID: <000301bffbe9$1d708b90$4d012ac7@warp-speed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Referring to my previous email:

Oops, I found the #define options in:  sym53c8xx_defs.h !
I also found a few config pins that were not set properly and probably explain the
problems I was having.

Still would like to know if anyone else is using the driver tho'.

Also, should I set the 53c895 to little endian mode?  It is set this way at the moment and
the chip is detected and config data read OK.

So, with the PPC in big endian and the SCSI chip in little endian, and the kernel compiled
accordingly, I should be able to access files on a disk that were written by an intel box,
properly, right?

Ron


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
