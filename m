Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 86CDCDDEB7
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Mar 2007 07:18:20 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l29KIGbm004615
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Mar 2007 13:18:16 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l29KIGN8012901
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Mar 2007 14:18:16 -0600 (CST)
Subject: The transparent PCI-Express bridge problem
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1173471495.23776.241.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Fri, 09 Mar 2007 14:18:15 -0600
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar,

Here is a lspci -xv from the 8544 DS board.  This is
the same board as the 8641 HPCN board, so they both have
the same "root complex is really a transparent bridge"
problem that needs to be resolved.

Please let me know if you need further or different info here.

HTH,
jdl




# lspci -xv
00:00.0 Power PC: Unknown device 1957:0030 (rev 10)
        !!! Invalid class 0b20 for header type 01
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=02, sec-latency=0
        I/O behind bridge: 00000000-00000fff
        Memory behind bridge: 00000000-000fffff
        Prefetchable memory behind bridge: 0000000000000000-0000000000000000
        Capabilities: [44] Power Management version 2
        Capabilities: [4c] #10 [0041]
00: 57 19 30 00 06 01 10 00 10 00 20 0b 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 02 00 00 00 00 20
20: 00 00 00 00 01 00 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 44 00 00 00 00 00 00 00 00 00 00 00
 
01:00.0 PCI bridge: Acer Laboratories Inc. [ALi]: Unknown device 5249 (prog-if 01 [Subtractive decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=01, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 00001000-00001fff
        Memory behind bridge: b0000000-b00fffff
        Capabilities: [90] Power Management version 2
        Capabilities: [98] #10 [0071]
00: b9 10 49 52 07 00 10 20 00 01 04 06 08 00 01 00
10: 00 00 00 00 00 00 00 00 01 02 02 00 10 10 00 22
20: 00 b0 00 b0 00 10 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 90 00 00 00 00 00 00 00 00 00 00 00
 
02:1c.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03) (prog-if 10 [OHCI])
        Subsystem: Acer Laboratories Inc. [ALi] M5237 USB
        Flags: bus master, 66Mhz, medium devsel, latency 128, IRQ 9
        Memory at b0000000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [60] Power Management version 2
        Capabilities: [68] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
00: b9 10 37 52 06 00 b0 02 03 10 03 0c 08 80 80 00
10: 00 00 00 b0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b9 10 37 52
30: 00 00 00 00 60 00 00 00 00 00 00 00 00 01 00 50
 
02:1c.1 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03) (prog-if 10 [OHCI])
        Subsystem: Acer Laboratories Inc. [ALi] M5237 USB
        Flags: bus master, 66Mhz, medium devsel, latency 128, IRQ 10
        Memory at b0001000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [60] Power Management version 2
        Capabilities: [68] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
00: b9 10 37 52 06 00 b0 02 03 10 03 0c 08 80 80 00
10: 00 10 00 b0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b9 10 37 52
30: 00 00 00 00 60 00 00 00 00 00 00 00 00 02 00 50
 
02:1c.2 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03) (prog-if 10 [OHCI])
        Subsystem: Acer Laboratories Inc. [ALi] M5237 USB
        Flags: bus master, 66Mhz, medium devsel, latency 128, IRQ 12
        Memory at b0002000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [60] Power Management version 2
        Capabilities: [68] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
00: b9 10 37 52 06 00 b0 02 03 10 03 0c 08 80 80 00
10: 00 20 00 b0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b9 10 37 52
30: 00 00 00 00 60 00 00 00 00 00 00 00 00 03 00 50
 
02:1c.3 USB Controller: Acer Laboratories Inc. [ALi]: Unknown device 5239 (rev 01) (prog-if 20)
        Subsystem: Acer Laboratories Inc. [ALi]: Unknown device 5238
        Flags: bus master, 66Mhz, medium devsel, latency 128, IRQ 7
        Memory at b0003000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] #0a [2090]
        Capabilities: [78] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
00: b9 10 39 52 06 00 b0 02 01 20 03 0c 08 80 80 00
10: 00 30 00 b0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b9 10 38 52
30: 00 00 00 00 50 00 00 00 00 00 00 00 00 04 10 20
 
02:1e.0 ISA bridge: Acer Laboratories Inc. [ALi]: Unknown device 1575
        Subsystem: Acer Laboratories Inc. [ALi]: Unknown device 1575
        Flags: bus master, medium devsel, latency 128
00: b9 10 75 15 0f 00 00 02 00 00 01 06 00 80 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b9 10 75 15
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 18
 
02:1e.1 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
        Flags: medium devsel
00: b9 10 01 71 00 00 00 02 00 00 80 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 
02:1f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c8) (prog-if 8a [Master SecP PriP])
        Subsystem: Acer Laboratories Inc. [ALi] M5229 IDE
        Flags: bus master, 66Mhz, medium devsel, latency 128, IRQ 6
        I/O ports at 1200 [size=8]
        I/O ports at 1208 [size=4]
        I/O ports at 1210 [size=8]
        I/O ports at 1218 [size=4]
        I/O ports at 1220 [size=16]
        Capabilities: [60] Power Management version 2
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
00: b9 10 29 52 05 04 b0 02 c8 8a 01 01 08 80 80 00
10: 01 12 00 00 09 12 00 00 11 12 00 00 19 12 00 00
20: 21 12 00 00 00 00 00 00 00 00 00 00 b9 10 29 52
30: 00 00 00 00 60 00 00 00 00 00 00 00 00 01 00 00
 
02:1f.1 Class 0106: Acer Laboratories Inc. [ALi]: Unknown device 5288 (rev 10) (prog-if 01)
        Subsystem: Acer Laboratories Inc. [ALi]: Unknown device 5288
        Flags: bus master, 66Mhz, medium devsel, latency 128, IRQ 6
        I/O ports at 1230 [size=8]
        I/O ports at 1238 [size=4]
        I/O ports at 1240 [size=8]
        I/O ports at 1248 [size=4]
        I/O ports at 1250 [size=16]
        Memory at b000c000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [60] Power Management version 2
        Capabilities: [70] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
00: b9 10 88 52 07 00 b0 02 10 01 06 01 08 80 80 00
10: 31 12 00 00 39 12 00 00 41 12 00 00 49 12 00 00
20: 51 12 00 00 00 c0 00 b0 00 00 00 00 b9 10 88 52
30: 00 00 00 00 60 00 00 00 00 00 00 00 00 01 00 00
 
