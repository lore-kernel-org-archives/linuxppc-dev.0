MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Linux support for MPC859T processor
Date: Wed, 2 Apr 2003 09:41:17 -0500
Message-ID: <2702075D4DE2B043BF5EB82E9CFAD45B093BF4@mail1.mediatrix.com>
From: "Jean-Denis Boyer" <jdboyer@mediatrix.com>
To: "Dmytro Bablinyuk" <dmytro.bablinyuk@tait.co.nz>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> 4.    The '859T has a dedicated 10/100Mbps ethernet MAC
> whereas the '860 has to use the serial communication controllers
> for ethernet operations.

OK for the 860, but the 860T has the Fast Ethernet Controller,
which is already supported (and very stable) in the kernel.

> * Could somebody please give me an advice on how much S/W
> work might be involved in the future to port linux from '860
> to '859T based on 1-5 (see above)

I don't see very much work. The first step is to make
the boot loader work. As long as your boot loader
correctly configure the various clocks, and pass this
information to the kernel through the board information
structure, the kernel should boot correctly. For the RTC,
we have never used this functionality on our 860T based boards.
For the core voltage, well, this is not related to the software.

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
