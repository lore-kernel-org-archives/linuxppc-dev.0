Message-ID: <F1BED55F35F4D3118C0F00E0295CFF4DFF9FDE@mail.mediatrix.com>
From: Jean-Denis Boyer <jdboyer@mediatrix.com>
To: "'Steve.Ferri@radisys.com'" <Steve.Ferri@radisys.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Unhandled interrupt 0, disabled
Date: Fri, 3 May 2002 11:22:00 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mr. Ferri,

> Which fix are you standing behind your __sti()
> fix using the sync or the 2.4.18 patch ?

Just put the 'sync' in __sti().
It seems to fix the problem on both 2.4.10 and 2.4.18,
which are the versions I have tested.

> I am using the B.3 version of the 8260
Thank you for the information!

--------------------------------------------
 Jean-Denis Boyer, B.Eng., System Architect
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
