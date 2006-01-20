Return-Path: <roman.kuzmenko@auriga.ru>
Subject: MPC5200, PCI, udelay(10)
From: Roman Kuzmenko <roman.kuzmenko@auriga.ru>
To: Linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
Content-Type: text/plain
Message-Id: <1137745904.4631.17.camel@trust.auriga.ru>
Mime-Version: 1.0
Date: 20 Jan 2006 11:31:44 +0300
Reply-To: roman.kuzmenko@auriga.ru
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello.

Please, help me to investigate why the delays present in the
"mpc5xxx_read_config_dword" and "mpc5xxx_write_config_dword" functions
in the "arch/ppc/kernel/mpc52xx_pci.c" file.

I.e.
==========================
  *(volatile u32 *)MPC5xxx_PCI_CAR = 0;
> udelay(10);
  return 0;
==========================

I was neither able to find any reference at the MPC5200 documentation
supplied by FreeScale nor reproduce any error with these lines got
removed.

Thank you.

-- 
Roman Kuzmenko <roman.kuzmenko@auriga.ru>
Auriga, Inc.
