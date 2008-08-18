Return-Path: <johnh.nm@gmail.com>
Received: from mail-gx0-f28.google.com (mail-gx0-f28.google.com
	[209.85.217.28]) by ozlabs.org (Postfix) with ESMTP id 0B9C4DDF5D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Aug 2008 08:25:02 +1000 (EST)
Received: by gxk9 with SMTP id 9so5076036gxk.9
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 18 Aug 2008 15:25:00 -0700 (PDT)
Message-ID: <a8299a810808181525h14a7bdcdt2f84fdb427ca4c24@mail.gmail.com>
Date: Mon, 18 Aug 2008 16:25:00 -0600
From: "john h" <johnh.nm@gmail.com>
To: linuxppc-embedded@ozlabs.org, u-boot@lists.denx.de
Subject: MV Linux uImage not working with u-boot, but zImage does
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I wasn't sure if this is a Linux issue or a u-boot issue.

We are using an older version of arch/ppc MontaVista Linux and having
a problem with u-boot.  We can build a zImage and convert it to a
uImage and it runs from u-boot fine.

If we build a uImage from MV, the kernel crashes as shown below. We
are using u-boot version U-Boot 1.3.0-rc3.

Yet we can boot an arch/ppc Linux kernel (uImage) that's based on
2.6.26.  Is there something we're not realizing that is different in
the u-boot interface?

Thanks,
John

version 2.6.10_mvl401-ml40x () (gcc version 3.4.3 (MontaVista 3.4.3
25.0.70.0501961
<4>mem_pieces_remove: [0,0) not in any region
<2>kernel BUG in free_bootmem_core at mm/bootmem.c:115!
<4>NIP: C02B4D04 LR: C02B2350 SP: C02A3F90 REGS: c02a3ee0 TRAP: 0700
 Not tainted
<6>GPR00: 00000000 C02A3F90 C026C720 C02D6EAC 00000000 00000001
C0270000 C026DC48
<6>GPR08: C0270000 00000000 00000000 00000000 48002028 0000A5A5
10000C00 00000000
<6>GPR16: 007FFF00 00000000 007FFE80 00800000 00000000 00000000
0FFFA304 00000000
<6>GPR24: 00000000 0FEDA958 00000DC0 007FFF3A 007FFF00 C02D0000
00000001 C02CEC04
<4>NIP [c02b4d04] free_bootmem_core+0x1c/0xac
<4>LR [c02b2350] do_init_bootmem+0xfc/0x140<4> Call trace:
<4> [c02b1cec] setup_arch+0xd8/0x1dc
<4> [c02a44d8] start_kernel+0x28/0x1bc
<4> [c0000240] skpinv+0x1e8/0x224
<0>Kernel panic - not syncing: Attempted to kill the idle task!
<4> <0> Rebooting in 180 seconds..
