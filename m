Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Message-ID: <40C8BB6C.4040709@246tNt.com>
Date: Thu, 10 Jun 2004 21:50:04 +0200
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: Matt Porter <mporter@KERNEL.CRASHING.ORG>
Cc: Tom Rini <trini@KERNEL.CRASHING.ORG>,
	linuxppc-dev@lists.linuxppc.org
Subject: [PATCH][RFC] MPC52xx basic support on linux 2.6 (was DMA support
 for MPC5xxx?)
References: <20040603090635.B7347@home.com> <20040603164245.B24A9C109F@atlas.denx.de> <20040603113302.A24468@home.com> <20040603185053.GN15195@smtp.west.cox.net> <40BF87BB.4020808@246tNt.com> <20040603134804.B24468@home.com>
In-Reply-To: <20040603134804.B24468@home.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi

 > Why not? You're the only one showing interest in supporting 5200 in
 >  2.6.

Well, I'm getting used to it. I'm also working on ARM IXP1200 on 2.6,
and I'm also the only one AFAIK ;)

 > Post the patch and if it's clean it can go in. The "i2c", I assume,
 > is an i2c host adapter driver so that needs to be separated so it
 > can go to gregkh. Don't lump it in with the include/asm-ppc and
 > arch/ppc core support. :)

Here it is, slightly delayed because of hardrive crash and need to
rename all 'Motorola' to 'Freescale' ;)

It's there :

http://www.246tNt.com/linux-2.5-mpc52xx-pending-20040610.diff
bk://bkbits.246tNt.com/linux-2.5-mpc52xx-pending

I haven't inlined or attached it because it's quite large ( ~80k ).
But still, here the summary of the changes, so you at least know what
you're pulling ;)

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/06/10 21:08:41+02:00 tnt@246tnt-laptop.(none)
#   Added support for Freescale MPC52xx, both the processor and the
LITE5200 devboard
#
# include/asm-ppc/mpc52xx_psc.h
#   2004/06/10 21:04:05+02:00 tnt@246tnt-laptop.(none) +202 -0
#
# include/asm-ppc/mpc52xx_psc.h
#   2004/06/10 21:04:05+02:00 tnt@246tnt-laptop.(none) +0 -0
#   BitKeeper file
/home/tnt/musicbox/kernel/linux-2.5-mpc52xx-pending/include/asm-ppc/mpc52xx_psc.h
#
# include/asm-ppc/mpc52xx.h
#   2004/06/10 21:04:04+02:00 tnt@246tnt-laptop.(none) +427 -0
#
# drivers/serial/mpc52xx_uart.c
#   2004/06/10 21:04:04+02:00 tnt@246tnt-laptop.(none) +872 -0
#
# include/asm-ppc/mpc52xx.h
#   2004/06/10 21:04:04+02:00 tnt@246tnt-laptop.(none) +0 -0
#   BitKeeper file
/home/tnt/musicbox/kernel/linux-2.5-mpc52xx-pending/include/asm-ppc/mpc52xx.h
#
# drivers/serial/mpc52xx_uart.c
#   2004/06/10 21:04:04+02:00 tnt@246tnt-laptop.(none) +0 -0
#   BitKeeper file
/home/tnt/musicbox/kernel/linux-2.5-mpc52xx-pending/drivers/serial/mpc52xx_uart.c
#
# arch/ppc/syslib/mpc52xx_setup.c
#   2004/06/10 21:04:03+02:00 tnt@246tnt-laptop.(none) +136 -0
#
# arch/ppc/syslib/mpc52xx_setup.c
#   2004/06/10 21:04:03+02:00 tnt@246tnt-laptop.(none) +0 -0
#   BitKeeper file
/home/tnt/musicbox/kernel/linux-2.5-mpc52xx-pending/arch/ppc/syslib/mpc52xx_setup.c
#
# arch/ppc/syslib/mpc52xx_pic.c
#   2004/06/10 21:04:02+02:00 tnt@246tnt-laptop.(none) +259 -0
#
# arch/ppc/platforms/lite5200.h
#   2004/06/10 21:04:02+02:00 tnt@246tnt-laptop.(none) +34 -0
#
# arch/ppc/syslib/mpc52xx_pic.c
#   2004/06/10 21:04:02+02:00 tnt@246tnt-laptop.(none) +0 -0
#   BitKeeper file
/home/tnt/musicbox/kernel/linux-2.5-mpc52xx-pending/arch/ppc/syslib/mpc52xx_pic.c
#
# arch/ppc/platforms/lite5200.h
#   2004/06/10 21:04:02+02:00 tnt@246tnt-laptop.(none) +0 -0
#   BitKeeper file
/home/tnt/musicbox/kernel/linux-2.5-mpc52xx-pending/arch/ppc/platforms/lite5200.h
#
# arch/ppc/platforms/lite5200.c
#   2004/06/10 21:04:01+02:00 tnt@246tnt-laptop.(none) +155 -0
#
# arch/ppc/platforms/lite5200.c
#   2004/06/10 21:04:01+02:00 tnt@246tnt-laptop.(none) +0 -0
#   BitKeeper file
/home/tnt/musicbox/kernel/linux-2.5-mpc52xx-pending/arch/ppc/platforms/lite5200.c
#
# arch/ppc/configs/lite5200_defconfig
#   2004/06/10 21:04:00+02:00 tnt@246tnt-laptop.(none) +477 -0
#
# arch/ppc/configs/lite5200_defconfig
#   2004/06/10 21:04:00+02:00 tnt@246tnt-laptop.(none) +0 -0
#   BitKeeper file
/home/tnt/musicbox/kernel/linux-2.5-mpc52xx-pending/arch/ppc/configs/lite5200_defconfig
#
# Documentation/powerpc/mpc52xx.txt
#   2004/06/10 21:03:59+02:00 tnt@246tnt-laptop.(none) +70 -0
#
# include/linux/serial_core.h
#   2004/06/10 21:03:59+02:00 tnt@246tnt-laptop.(none) +3 -0
#   Added port type for the Freescale MPC52xx PSC
#
# include/asm-ppc/ppcboot.h
#   2004/06/10 21:03:59+02:00 tnt@246tnt-laptop.(none) +7 -0
#   Added specific fields for the Freescale MPC52xx
#
# drivers/serial/Makefile
#   2004/06/10 21:03:59+02:00 tnt@246tnt-laptop.(none) +1 -0
#   Added options for the Freescale MPC52xx PSC
#
# drivers/serial/Kconfig
#   2004/06/10 21:03:59+02:00 tnt@246tnt-laptop.(none) +18 -0
#   Added options for the Freescale MPC52xx PSC
#
# arch/ppc/syslib/Makefile
#   2004/06/10 21:03:59+02:00 tnt@246tnt-laptop.(none) +1 -0
#   Added options for the Freescale MPC52xx and the standard LITE5200
devboard
#
# arch/ppc/platforms/Makefile
#   2004/06/10 21:03:59+02:00 tnt@246tnt-laptop.(none) +1 -0
#   Added options for the Freescale MPC52xx and the standard LITE5200
devboard
#
# arch/ppc/kernel/cputable.c
#   2004/06/10 21:03:59+02:00 tnt@246tnt-laptop.(none) +8 -0
#   Added entry for the Freescale MPC52xx
#
# arch/ppc/Kconfig
#   2004/06/10 21:03:59+02:00 tnt@246tnt-laptop.(none) +20 -8
#   Added options for the Freescale MPC52xx and the standard LITE5200
devboard
#
# Documentation/powerpc/mpc52xx.txt
#   2004/06/10 21:03:59+02:00 tnt@246tnt-laptop.(none) +0 -0
#   BitKeeper file
/home/tnt/musicbox/kernel/linux-2.5-mpc52xx-pending/Documentation/powerpc/mpc52xx.txt
#



Sylvain Munaut


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
