Message-ID: <F1BED55F35F4D3118C0F00E0295CFF4D414C7E@mail.mediatrix.com>
From: Jean-Denis Boyer <jdboyer@mediatrix.com>
To: "'Michael Habermann'" <MHabermann@gmx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Reducing glibc with mklibs.sh
Date: Mon, 29 Oct 2001 17:36:30 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


It looks like mklibs.sh does not find the map file for libm.

In your script:
> cp *.map ../lib/
might be bad, because the makefile of glibc produces libm.map,
while mklibs.sh looks for libm_pic.map (the name differs).

Either you rename the file when copying it, or you modify mklibs.sh.

--------------------------------------------
 Jean-Denis Boyer, B.Eng., Technical Leader
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
