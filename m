MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Question about modules
Date: Fri, 28 Feb 2003 13:27:26 -0500
Message-ID: <2702075D4DE2B043BF5EB82E9CFAD45B093BC7@mail1.mediatrix.com>
From: "Jean-Denis Boyer" <jdboyer@mediatrix.com>
To: "Ibon Gotxi Garcia" <igotxi@jazzfree.com>
Cc: "Linux PPC embedded" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Everything works, till I try to insmod it: I get m8xx_cpm_alloc and
> m8xx_cpm_hostalloc as unresolved symbols.

In commproc.c, add the following line:
  EXPORT_SYMBOL(m8xx_cpm_hostalloc);


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
