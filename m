Message-ID: <3B5708DD.E0788B8B@comdev.cc>
Date: Thu, 19 Jul 2001 09:20:45 -0700
From: Adam Wozniak <adam.wozniak@comdev.cc>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: fcc_enet Phy detection
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


(solved previous problem, Dan Malek was right; it was an incorrect DRAM
refresh parameter)

Is this normal?

eth0: FCC ENET Version 0.2, 08:00:22:70:70:63
fec: Phy @ 0x0, type 0x00000000
fec: Phy @ 0x1, type 0x00000000
fec: Phy @ 0x2, type 0x00000000
fec: Phy @ 0x3, type 0x00000000
fec: Phy @ 0x4, type 0x00000000
fec: Phy @ 0x5, type 0x00000000
fec: Phy @ 0x6, type 0x00000000
fec: Phy @ 0x7, type 0x00000000
fec: Phy @ 0x8, type 0x00000000
fec: Phy @ 0x9, type 0x00000000
fec: Phy @ 0xa, type 0x00000000
fec: Phy @ 0xb, type 0x00000000
fec: Phy @ 0xc, type 0x00000000
fec: Phy @ 0xd, type 0x00000000
fec: Phy @ 0xe, type 0x00000000
fec: Phy @ 0xf, type 0x00000000
fec: Phy @ 0x10, type 0x00000000
fec: Phy @ 0x11, type 0x00000000
fec: Phy @ 0x12, type 0x00000000
fec: Phy @ 0x13, type 0x00000000
fec: Phy @ 0x14, type 0x00000000
fec: Phy @ 0x15, type 0x00000000
fec: Phy @ 0x16, type 0x00000000
fec: Phy @ 0x17, type 0x00000000
fec: Phy @ 0x18, type 0x00000000
fec: Phy @ 0x19, type 0x00000000
fec: Phy @ 0x1a, type 0x00000000
fec: Phy @ 0x1b, type 0x00000000
fec: Phy @ 0x1c, type 0x00000000
fec: Phy @ 0x1d, type 0x00000000
fec: Phy @ 0x1e, type 0x00000000
fec: Phy @ 0x1f, type 0x00000000

--
Adam Wozniak (KG6GZR)   COM DEV Wireless - Digital and Software Systems
awozniak@comdev.cc      3450 Broad St. 107, San Luis Obispo, CA 93401
                        http://www.comdev.cc
                        Voice: (805) 544-1089       Fax: (805) 544-2055

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
