Date: Thu, 23 Mar 2000 20:29:44 +0100
From: Claus <cesli@ewetel.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: different h/w addresses on one eth
Message-ID: <20000323202943.A807@olis.north.de>
Reply-To: cl.en@gmx.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


sorry, one question from another newbie

pb3400, builtin eth {not the combo card}
and de4x5:
Mar 23 19:57:53 arma kernel: eth0: DC21041 at 0x0400 (PCI bus 0, device 14), h/w address 00:05:02:26:3a:02,
Mar 23 19:57:53 arma kernel:       and requires IRQ28 (provided by PCI BIOS).
Mar 23 19:57:53 arma kernel: de4x5.c:V0.544 1999/5/8 davies@maniac.ultranet.com
Mar 23 19:57:57 arma kernel: eth0: media is unconnected, link down or incompatible connection.

now tulip.o:
Mar 23 20:03:27 arma kernel: tulip.c:v0.91g-ppc 7/16/99 becker@cesdis.gsfc.nasa.gov
Mar 23 20:03:27 arma kernel: eth0: Digital DC21041 Tulip rev 33 at 0x400, 00:A0:40:64:5C:40, IRQ 28.
Mar 23 20:03:27 arma kernel: eth0: 21041 Media table, default media ffff (Autosense).
Mar 23 20:03:27 arma kernel: eth0:  21041 media #0, 10baseT.
Mar 23 20:03:27 arma kernel: eth0:  21041 media #1, 10base2.
Mar 23 20:03:27 arma kernel: eth0:  21041 media #2, AUI.
Mar 23 20:03:30 arma kernel: eth0: No 21041 10baseT link beat, Media switched to 10base2.

hm..
/usr/doc/LDP/nag/node9.html#SECTION003320000 says:
A host is addressed by a six-byte address hard-coded into the
firmware of its Ethernet board. These addresses are usually written as a sequence of two-digit hex numbers separated by colons, as in aa:bb:cc:dd:ee:ff.

got someone of this list a solution for different h/w addresses on one eth card?

thx
Claus

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
