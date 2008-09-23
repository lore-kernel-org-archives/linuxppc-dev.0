Return-Path: <mail4mz@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.153])
	by ozlabs.org (Postfix) with ESMTP id ED2B9DDF00
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Sep 2008 04:56:14 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so1982983fga.39
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Sep 2008 11:56:11 -0700 (PDT)
Message-ID: <5c9cd53b0809231156o3c24c053y26861d8f1cf24a93@mail.gmail.com>
Date: Tue, 23 Sep 2008 14:56:11 -0400
From: "mike zheng" <mail4mz@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Uboot-1.2.0 on MPC8360EMDS board
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

Hello,

I am having problem when I try to bootup MPC8360EMDS with Uboot1.2.
The following are logs. The board reboot when the uboot tried to run
on the RAM. Any idea on this issue?

Thanks,

Mike


U-Boot 1.2.1 (Sep 23 2008 - 14:35:42) MPC83XX

Clock configuration:
  Coherent System Bus:  264 MHz
  Core:                 528 MHz
  QE:                   396 MHz
  Local Bus Controller: 264 MHz
  Local Bus:             66 MHz
  DDR:                  264 MHz
  DDR Secondary:        264 MHz
  SEC:                   88 MHz
  I2C1:                 264 MHz
  I2C2:                 264 MHz
CPU: MPC8360E, Rev: 21 at 528 MHz
Board: Freescale MPC8360EMDS
I2C:   ready
DRAM:
cs0_bnds = 0x0000000f
cs0_config = 0x80000102
DDR:bar=0x00000000
DDR:ar=0x8000001b
DDR:Module maximum data rate is: 400Mhz
DDR:Effective data rate is: 266Mhz
DDR:The MSB 1 of CAS Latency is: 4
Errata DDR6 (debug_reg=0x002c0000)
DDR:timing_cfg_1=0x37353321
DDR:timing_cfg_2=0x00000800

   DDR DIMM: data bus width is 64 bit with ECC
DDR:sdram_mode=0x00000032
DDR:sdram_interval=0x045b0100
DDR:sdram_clk_cntl=0x00000000
   DDRC ECC mode: OFF
DDR:sdram_cfg=0xc2000000

   SDRAM on Local Bus: 64 MB
   DDR RAM: 256 MB
Top of RAM usable for U-Boot at: 10000000
Reserving 205k for U-Boot at: 0ffcc000
Reserving 136k for malloc() at: 0ffaa000
Reserving 76 Bytes for Board Info at: 0ffa9fb4
Reserving 104 Bytes for Global Data at: 0ffa9f4c
Stack Pointer at: 0ffa9f28
