MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: boot flash problem,
Date: Fri, 6 Dec 2002 12:41:26 -0500
Message-ID: <2702075D4DE2B043BF5EB82E9CFAD45B093B99@mail1.mediatrix.com>
From: "Jean-Denis Boyer" <jdboyer@mediatrix.com>
To: "Li Xiangrong" <lixiangrong@china.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> bdi configuration file:
> ..
> WM32    0xFF000100      0xFFE00801      ;BR0
> WM32    0xFF000104      0xFFC00160      ;OR0 : 2MB, all

If you use a flash of 4MB, then move the base address from 0xFFE00000 to 0xFFC00000.
Set the base address in BR0 to 0xFFC0, not 0xFFE0.

Your BDI probably programmed the boot loader at the wrong place.

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
