From: brian.auld@adic.com
Message-ID: <995FF289C9D69747A09E42992644595405B2363E@penguin.adic.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: U-boot on Ebony: Flash burned ... no menu on reboot
Date: Fri, 31 Jan 2003 16:31:53 -0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


It appears that I successfully programmed u-boot into flash. However, I get
no menu at the ebony serial port when I reboot?? Any ideas why. Has anyone
had this before on 440GP/Ebony platform.

Below is the sequence of erasing/programming and then displaying the point
in memory(flash) where the board boots from.

BDI>erase
Erasing flash at 0xfff80000
Erasing flash at 0xfff90000
Erasing flash at 0xfffa0000
Erasing flash at 0xfffb0000
Erasing flash at 0xfffc0000
Erasing flash at 0xfffd0000
Erasing flash at 0xfffe0000
Erasing flash at 0xffff0000
Erasing flash passed
BDI>prog 0xfff80000 u-boot.bin bin
Programming u-boot.bin , please wait ....
Programming flash passed
BDI>md 0xfff80000
fff80000 : 27051956 552d426f 6f742030 2e322e30  '..VU-Boot 0.2.0
fff80010 : 20284a61 6e203331 20323030 33202d20   (Jan 31 2003 -
fff80020 : 30353a31 323a3535 29000000 00000000  05:12:55).......
fff80030 : 00000000 00000000 00000000 00000000  ................
fff80040 : 00000000 00000000 00000000 00000000  ................
fff80050 : 00000000 00000000 00000000 00000000  ................
fff80060 : 00000000 00000000 00000000 00000000  ................
fff80070 : 00000000 00000000 00000000 00000000  ................
fff80080 : 00000000 00000000 00000000 00000000  ................
fff80090 : 00000000 00000000 00000000 00000000  ................
fff800a0 : 00000000 00000000 00000000 00000000  ................
fff800b0 : 00000000 00000000 00000000 00000000  ................
fff800c0 : 00000000 00000000 00000000 00000000  ................
fff800d0 : 00000000 00000000 00000000 00000000  ................
fff800e0 : 00000000 00000000 00000000 00000000  ................
fff800f0 : 00000000 00000000 00000000 00000000  ................
BDI>

-- Brian


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
