MIME-Version: 1.0
Subject: RE: RAMDISK Segv
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 4 Dec 2003 16:13:25 -0500
Message-ID: <AB5AF73EAF23304EA1B932174137CED7030445@m5tmail.m5t.com>
From: "Jean-Denis Boyer" <jdboyer@m5t.com>
To: "Kevin A. Sapp" <Kevin.Sapp@catapult.com>
Cc: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kevin,

> Total memory = 32MB; using 64kB for hash table (at c0140000)

You should not get this line with a 8275, which has a 603e core
and does not support the HPTE.
The CPU revision is not correctly recognized.
You will have to patch arch/ppc/kernel/cputable.c

Regards,
--------------------------------------------
 Jean-Denis Boyer, Eng.
 M5T Centre d'Excellence en Télécom Inc.
 4283 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-3972 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
