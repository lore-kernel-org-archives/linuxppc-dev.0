Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <2702075D4DE2B043BF5EB82E9CFAD45B093B1E@mail1.mediatrix.com>
From: Jean-Denis Boyer <jdboyer@mediatrix.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: BDI2000 on an 8250
Date: Fri, 26 Jul 2002 11:07:33 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Has anybody successfully connected a BDI2000 to a 8250 processor?

It works very well on my custom board with an 8260 (HIP3). We prepared an
identical board with an 8250 (HIP4) (with the required modifications), but I
have problems executing helper code out of it. It almost always hangs with
the message "PPC: timeout while waiting for freeze"... sometimes (rarely) it
works. The software on it (kernel 2.4.19-rc2) works very well. No one could
help me at Abatron (the issue is still pending), since apparently, nobody
use that processor yet. The only answer I got is that an 8260A is supported
(and was tested), and for COP debugging, it is the same thing.

Thanks.
--------------------------------------------
 Jean-Denis Boyer, B.Eng., System Architect
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
