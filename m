Message-ID: <3AC76542.A4D27697@bigwig.net>
Date: Sun, 01 Apr 2001 17:28:34 +0000
From: Jim Chapman <jim.chapman@bigwig.net>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: MII PHY support?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Is anyone working on adding MII PHY support?

I've implemented support for my custom 8260 board which has a quad enet
phy. Now I'm about to add code into fcc_enet.c to handle things like
link autonegotiation and state changes. But before I go too far, I
thought it would be useful to find out if I am about to duplicate work.

I'm not ready to publish anything yet; I already have generic MII
support (not ppc specific) with hooks to phy device specific drivers and
architecture dependent h/w interface (i.e. board dependent 8260 MDIO).
Over time, new phy device drivers could be added and support for other
boards too. I envisage new ioctls to control/view the phy, and patching
ifconfig to use them.

Please let me know if you know of similar work.

Thanks

Jim


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
