Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <000b01c1fb37$50751cf0$1a11efcb@industrialDiv.hanasys.co.kr>
Reply-To: "Sangmoon Kim" <dogoil@etinsys.com>
From: "Sangmoon Kim" <dogoil@etinsys.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: File System on 64-bit-bus-width Flash memory
Date: Tue, 14 May 2002 20:05:53 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I want to make a flash file system on a custom MPC755 board with a 64-bit (bus width) flash memory.
I set CONFIG_MTD_PHYSMAP_BUSWIDTH = 8 at kernel configure, and when it boots the following message appears.

physmap flash device: 400000 at 7c000000
genprobe_new_chip called with unsupported buswidth 8
CFI: Found no Physically mapped flash device at location zero

Is it possible to make a flash file system with a flash memory of  64 bit bus width? If possible, what's the method? Please let me know.

- Sangmoon Kim -

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
