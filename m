Return-Path: <epuru@lycos.com>
Received: from smail1.lycosmail.lycos.com (bos-mail-smail3.bos.lycos.com
	[209.202.208.43]) by ozlabs.org (Postfix) with ESMTP id 0C73167BDC
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Oct 2006 03:58:04 +1000 (EST)
Received: (from hanadmin@localhost)
	by bos-mail-wwl4.lycosmail.com (8.12.9/8.9.1) id k9CHrBg0021419
	for <linuxppc-embedded@ozlabs.org>; Fri, 13 Oct 2006 02:53:11 +0900
Content-Type: text/html; charset=utf-8
From: "prashanth epuru" <epuru@lycos.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: lite5200B boot up error with PCI card
Date: Thu, 12 Oct 2006 13:53:11 -0400 (EDT)
Message-Id: <20061012135311.HM.0000000000000BP@epuru.bos-mail-wwl4.lycos.com>
Errors-To: <epuru@lycos.com>
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Everybody,
<br>
<br>I am trying to boot up lite5200B version 1.0 freescale board with u boot and it boots up properly without any PCI card.
<br>
<br>The lite5200B crashes while bootup if a PCI card (PCI to mini PCI converter card of Catalyst Enterprises) is inserted.
<br>
<br>Is there any limitation with PCI to min PCI converter cards with lite5200B board? I have verified the card to be 3.3v PCI card, so its not the 3.3V issue.
<br>
<br>Has anyone faced this problem earlier and does any one know any solution for this, i'm cluesless?
<br>
<br>Also I looked for this error in the errata (MPC5200 Errata Rev. 4), but there is nothing in regard to this particular case.
<br>
<br>Below is the error thats occuring.
<br>
<br>U-Boot 1.1.3 (Aug 10 2005 - 11:07:57)
<br>
<br>CPU: MPC5200 v2.2 at 462 MHz
<br>Bus 132 MHz, IPB 132 MHz, PCI 33 MHz
<br>Board: Freescale MPC5200 (Lite5200B)
<br>I2C: 85 kHz, ready
<br>DRAM: 256 MB
<br>FLASH: 32 MB
<br>PCI: Bus Dev VenId DevId Class Int
<br>Bus Fault @ 0x0ffa2b80, fixup 0x00000000
<br>Machine check in kernel mode.
<br>Caused by (from msr): regs 0ff4ed20 Unknown values in msr
<br>NIP: 0FFA2B80 XER: 00000000 LR: 0FFA2B74 REGS: 0ff4ed20 TRAP: 0200 DAR: 20446576MSR: 00003000 EE: 0 PR: 0 FP: 1 ME: 1 IR/DR: 00
<br>
<br>GPR00: 0FFA2B74 0FF4EE10 E9BFFFBB FFFFFFFF FFFFFFFF 00000000 00000000 008498B3
<br>GPR08: 0FF83AC8 AAAAAAAA 0FFC8A58 00000000 48004028 FFFF7FFB 0FFB9000 1007F000
<br>GPR16: D6FF37FF FEFF3DFF DFE7F7F9 6FFF6BFE 00003002 00000001 00000000 00000000
<br>GPR24: 0FF827B8 00000001 00000000 0FF4EE58 F0000DF8 0FF4EF84 0FFB9594 0FF4EE96
<br>Call backtrace:
<br>machine check
<br>
<br>Without the PCI card it boots up properly, below is the log for the same.
<br>
<br>U-Boot 1.1.3 (Aug 10 2005 - 11:07:57)
<br>
<br>CPU:   MPC5200 v2.2 at 462 MHz
<br>       Bus 132 MHz, IPB 132 MHz, PCI 33 MHz
<br>Board: Freescale MPC5200 (Lite5200B)
<br>I2C:   85 kHz, ready
<br>DRAM:  256 MB
<br>FLASH: 32 MB
<br>PCI:   Bus Dev VenId DevId Class Int
<br>        00  1a  1057  5809  0680  00
<br>In:    serial
<br>Out:   serial
<br>Err:   serial
<br>Net:   FEC ETHERNET
<br>IDE:   Bus 0: OK
<br>  Device 0: not available
<br>  Device 1: not available
<br>
<br>Type "run flash_nfs" to mount root filesystem over NFS
<br>
<br>Hit any key to stop autoboot:  0
<br>=>
<br>
<br>regards,
<br>Prashanth
