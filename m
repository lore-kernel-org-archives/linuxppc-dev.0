From: greggiraud@netcourrier.com
To: linuxppc-embedded@lists.linuxppc.org
Cc: James.Dang@gdcanada.com
Subject: boot linux mpc8260ads
Date: Fri, 11 Apr 2003 18:50:52 CEST
Mime-Version: 1.0
Message-Id: <mnet1.1050079852.29015.greggiraud@netcourrier.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


greggiraud@netcourrier.com

Hi, very strange...
I use a MPC8260ADS card. IMMR=0xf0000000 on mpc8260ads.h (in ppcboot) and IMAP_ADDR=0xf0000000  in ppcboot.h (/linux/...).
moreover mpc8260ads.h contains <asm/ppcboot.h>.
I put pImage and pRamdisk in flash at 0xff800000 and at 0xfff40000 (after ppcboot.bin)
So Normally there is no pb, but...

let's see!

PPCBoot 1.2.1 (Apr 10 2003 - 16:13:49)

MPC8260 Reset Status: External Soft, External Hard

MPC8260 Clock Configuration
 - Bus-to-Core Mult 3x, VCO Div 2, 60x Bus Freq  33-100, Core Freq 100-300
 - dfbrg 0, corecnf 0x08, busdf 3, cpmdf 1, plldf 0, pllmf 1
 - vco_out  266666664, scc_clk   66666666, brg_clk   66666666
 - cpu_clk  199999998, cpm_clk  133333332, bus_clk   66666666

CPU:   MPC8260 (Rev 14, Mask A.0(A) 2K25A) at 199.999 MHz
Board: Motorola MPC8260ADS
I2C:   ready
DRAM:  16 MB
FLASH:  8 MB
*** Warning - bad CRC, using default environment

In:    serial
Out:   serial
Err:   serial
Hit any key to stop autoboot:  0
=> bootm fff40000 ff800000
## Booting image at fff40000 ...
   Image Name:   Linux-2.4.4
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    471457 Bytes = 460.4 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at ff800000 ...
   Image Name:   Simple Ramdisk Image
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    567988 Bytes = 554.7 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 00ed4000, end 00f5eab4 ... OK
TTaammoooo  MM  ii  kkff  ssttl a 0500

                                      iu eso .. ro@@clotlcllmi)(c eein29. 0001 p
oe1:0pgse. 06) 5juaa 01:62  S 03

        oe2:0pgs

airtn ea op.11..  ggIIdln:ro==e/a w
nnyyaaeeaa al nre:24 odr ,134btsaaiibb  11  rrlloo,,6kdt,4kii,0 ihe)
uue-ah ahtbeetis 04(re:0 06bts

                              aeccehs al nre:49 odr ,134bts
                                                           IIddcch ahtbeetis 04(
re:1 12bts
nn  TT00ooLLuu22X
MMAA  iirvrin00 BBeeuunnwwss nvriyCmue oit E309SSrrnnkwp 18

               tS nSC t000,BG


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
