Message-ID: <2702075D4DE2B043BF5EB82E9CFAD45B0B3F74@mail1.mediatrix.com>
From: Jean-Denis Boyer <jdboyer@mediatrix.com>
To: "'Apostolos Meliones'" <meliones@ellemedia.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Segmentation fault and 8260 vs 8264
Date: Fri, 13 Sep 2002 09:55:53 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This bug has been fixed in 2.4.11. in arch/ppc/kernel/cputable.c, line 172.

A bit was missing in the mask for the 82xx,
and the kernel could not recognized it was a 603e core.

I've got the same problem with my 8250.


Regards,
--------------------------------------------
 Jean-Denis Boyer, B.Eng., Technical Leader
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
