Message-ID: <F1BED55F35F4D3118C0F00E0295CFF4DFFA04F@mail.mediatrix.com>
From: Jean-Denis Boyer <jdboyer@mediatrix.com>
To: "'acurtis@onz.com'" <acurtis@onz.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Poor 8260 FCC Ethernet performance
Date: Thu, 30 May 2002 23:25:29 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Allen,

The 8260 Ethernet controller needs to know about the duplex mode in which
the PHY operates. The driver sets it to half duplex by default, and needs
the feed back of the PHY to set it to full duplex.

As you may know, the hub always operates in half duplex, while the switch
usually operates in full duplex, if it is directly connected to your unit,
and your PHY accepts to negociate to full duplex.

Both the Ethernet controller and the PHY should be set to the same mode, or
your likely to run into communication problems (as you see ;-).

Regards,

--------------------------------------------
 Jean-Denis Boyer, B.Eng., System Architect
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
