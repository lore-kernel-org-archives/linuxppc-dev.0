Message-ID: <20030212212707.37800.qmail@web14805.mail.yahoo.com>
Date: Wed, 12 Feb 2003 13:27:07 -0800 (PST)
From: Allen Curtis <ajcurtis84@yahoo.com>
Reply-To: acurtis@onz.com
Subject: Fwd: BK 8260 2.5 patches
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-235934558-1045085227=:37365"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--0-235934558-1045085227=:37365
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline


Note: forwarded message attached.


--0-235934558-1045085227=:37365
Content-Type: message/rfc822

X-Apparently-To: ajcurtis84@yahoo.com via 216.136.224.219; 12 Feb 2003 13:11:52 -0800 (PST)
X-Track: 1: 100
Return-Path: <acurtis@ws01.onz.com>
Received: from 67.121.61.113  (EHLO ws01.onz.com) (67.121.61.113)
  by mta110.mail.scd.yahoo.com with SMTP; 12 Feb 2003 13:11:51 -0800 (PST)
Received: (from acurtis@localhost)
	by ws01.onz.com (8.11.6/8.11.6) id h1CLBpv01634
	for ajcurtis84@yahoo.com; Wed, 12 Feb 2003 13:11:51 -0800
Date: Wed, 12 Feb 2003 13:11:51 -0800
From: Allen Curtis <acurtis@ws01.onz.com>
To: ajcurtis84@yahoo.com
Subject: 8260 2.5 patches
Content-Length: 7929

# User:	acurtis
# Host:	ws01.onz.com
# Root:	/misc/dual166/acurtis/dev/linux/est8260-ppc2.5

# Patch vers:	1.3
# Patch type:	REGULAR

== ChangeSet ==
torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
paulus@samba.org|ChangeSet|20021128025329|00964
D 1.728 02/12/17 08:12:57-08:00 acurtis@ws01.onz.com +17 -0
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Removed references to request_8xxirq() for 8260.
c
c Added platform specific setup.c in arch/ppc/platforms and converted m8260_setup.c
c to a generic library providing default functionality.
c
c Modified platform includes to be better controlled under arch/ppc/platforms
K 45648
P ChangeSet
------------------------------------------------

0a0
> patch@athlon.transmeta.com|arch/ppc/mm/pgtable.c|20020205201138|16734|2cc7bfaab84a832 acurtis@ws01.onz.com|arch/ppc/mm/pgtable.c|20021217160850|62708
> acurtis@ws01.onz.com|arch/ppc/platforms/tqm8260_setup.c|20021217160851|18068|37366f7bd3b0e553 acurtis@ws01.onz.com|arch/ppc/platforms/tqm8260_setup.c|20021217160852|29709
> torvalds@athlon.transmeta.com|arch/ppc/kernel/ppc_ksyms.c|20020205174025|24555|ed26bb10e68d159b acurtis@ws01.onz.com|arch/ppc/kernel/ppc_ksyms.c|20021217160850|33772
> torvalds@athlon.transmeta.com|arch/ppc/kernel/m8260_setup.c|20020205174025|51000|f1612ef7c8f2ae4b acurtis@ws01.onz.com|arch/ppc/syslib/m8260_setup.c|20021217160850|51660
> torvalds@athlon.transmeta.com|arch/ppc/8260_io/uart.c|20020205174026|11166|c6dfa4adcc8b2a32 acurtis@ws01.onz.com|arch/ppc/8260_io/uart.c|20021217160849|00559
> torvalds@athlon.transmeta.com|arch/ppc/mm/init.c|20020205174024|33660|9e754c1b56624c1c acurtis@ws01.onz.com|arch/ppc/mm/init.c|20021217160850|37031
> torvalds@athlon.transmeta.com|arch/ppc/configs/est8260_defconfig|20020205174025|33303|a4b94eb0f03bd339 acurtis@ws01.onz.com|arch/ppc/configs/est8260_defconfig|20021217160850|24055
> torvalds@athlon.transmeta.com|include/asm-ppc/est8260.h|20020205173950|11533|1f594fa3c867fc1 acurtis@ws01.onz.com|arch/ppc/platforms/est8260.h|20021217160850|24774
> torvalds@athlon.transmeta.com|include/asm-ppc/mpc8260.h|20020205173950|12837|c28125d81075883e acurtis@ws01.onz.com|include/asm-ppc/mpc8260.h|20021217160850|17971
> torvalds@athlon.transmeta.com|arch/ppc/8260_io/enet.c|20020205174026|10460|c6435561d2676f77 acurtis@ws01.onz.com|arch/ppc/8260_io/enet.c|20021217160849|18241
> acurtis@ws01.onz.com|arch/ppc/platforms/est8260_setup.c|20021217160850|44729|dbe6c7d1b42d47f2 acurtis@ws01.onz.com|arch/ppc/platforms/est8260_setup.c|20021217160851|00726
> paulus@tango.paulus.ozlabs.org|arch/ppc/platforms/Makefile|20020210112152|00854|bcaddbb53429da46 acurtis@ws01.onz.com|arch/ppc/platforms/Makefile|20021217160850|45014
> torvalds@athlon.transmeta.com|arch/ppc/8260_io/fcc_enet.c|20020205174026|12002|ccaf07782eab2409 acurtis@ws01.onz.com|arch/ppc/8260_io/fcc_enet.c|20021217160849|23810
> paulus@tango.paulus.ozlabs.org|arch/ppc/configs/TQM8260_defconfig|20020210111437|58304|a9f2bd198d4ee29c acurtis@ws01.onz.com|arch/ppc/configs/TQM8260_defconfig|20021217160850|62729
> acurtis@ws01.onz.com|arch/ppc/platforms/mpc82xx.h|20021217160850|16435|94f3664bdcd4f777 acurtis@ws01.onz.com|arch/ppc/platforms/mpc82xx.h|20021217160851|04862
> paulus@tango.paulus.ozlabs.org|arch/ppc/boot/simple/embed_config.c|20020210110805|35004|c8486d19339b8bcb acurtis@ws01.onz.com|arch/ppc/boot/simple/embed_config.c|20021217160849|35097
> paulus@tango.paulus.ozlabs.org|arch/ppc/platforms/tqm8260.h|20020210112152|55541|ee7331884ebfa3cf acurtis@ws01.onz.com|arch/ppc/platforms/tqm8260.h|20021217160850|26213

== arch/ppc/platforms/est8260_setup.c ==
New file: arch/ppc/platforms/est8260_setup.c
V 4

acurtis@ws01.onz.com|arch/ppc/platforms/est8260_setup.c|20021217160850|44729|dbe6c7d1b42d47f2
D 1.0 02/12/17 08:08:50-08:00 acurtis@ws01.onz.com +0 -0
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
c BitKeeper file /misc/dual166/acurtis/dev/linux/est8260-ppc2.5/arch/ppc/platforms/est8260_setup.c
K 44729
P arch/ppc/platforms/est8260_setup.c
R dbe6c7d1b42d47f2
X 0x821
------------------------------------------------


acurtis@ws01.onz.com|arch/ppc/platforms/est8260_setup.c|20021217160850|44729|dbe6c7d1b42d47f2
D 1.1 02/12/17 08:08:50-08:00 acurtis@ws01.onz.com +65 -0
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
F 1
K 726
O -rw-rw-r--
P arch/ppc/platforms/est8260_setup.c
------------------------------------------------

I0 65
/*
 * arch/ppc/platforms/est8260_setup.c
 *
 * EST8260 platform support
 *
 * Author: Allen Curtis <acurtis@onz.com>
 *
 * Copyright 2002 Ones and Zeros, Inc.
 *
 * This program is free software; you can redistribute  it and/or modify it
 * under  the terms of  the GNU General  Public License as published by the
 * Free Software Foundation;  either version 2 of the  License, or (at your
 * option) any later version.
 */
\
#include <linux/config.h>
#include <linux/seq_file.h>
\
#include <asm/mpc8260.h>
#include <asm/machdep.h>
\
static void (*callback_setup_arch)(void);
\
extern unsigned char __res[sizeof(bd_t)];
\
extern void m8260_init(unsigned long r3, unsigned long r4,
	unsigned long r5, unsigned long r6, unsigned long r7);
\
static int
est8260_show_cpuinfo(struct seq_file *m)
{
	bd_t	*binfo = (bd_t *)__res;
\
	seq_printf(m, "vendor\t\t: EST Corporation\n"
		      "machine\t\t: SBC8260 PowerPC\n"
		      "\n"
		      "mem size\t\t: 0x%08x\n"
		      "console baud\t\t: %d\n"
		      "\n",
		      binfo->bi_memsize,
		      binfo->bi_baudrate);
	return 0;
}
\
static void __init
est8260_setup_arch(void)
{
	printk("EST SBC8260 port (C) 2002 Ones and Zeros, Inc. (support@onz.com)\n");
	callback_setup_arch();
}
\
void __init
platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
	      unsigned long r6, unsigned long r7)
{
	/* Generic 8260 platform initialization */
	m8260_init(r3, r4, r5, r6, r7);
\
	/* Anything special for this platform */
	ppc_md.show_cpuinfo	= est8260_show_cpuinfo;
\
	callback_setup_arch	= ppc_md.setup_arch;
	ppc_md.setup_arch	= est8260_setup_arch;
}
\

== arch/ppc/platforms/mpc82xx.h ==
New file: arch/ppc/platforms/mpc82xx.h
V 4

acurtis@ws01.onz.com|arch/ppc/platforms/mpc82xx.h|20021217160850|16435|94f3664bdcd4f777
D 1.0 02/12/17 08:08:50-08:00 acurtis@ws01.onz.com +0 -0
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
c BitKeeper file /misc/dual166/acurtis/dev/linux/est8260-ppc2.5/arch/ppc/platforms/mpc82xx.h
K 16435
P arch/ppc/platforms/mpc82xx.h
R 94f3664bdcd4f777
X 0x821
------------------------------------------------


acurtis@ws01.onz.com|arch/ppc/platforms/mpc82xx.h|20021217160850|16435|94f3664bdcd4f777
D 1.1 02/12/17 08:08:50-08:00 acurtis@ws01.onz.com +42 -0
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
F 1
K 4862
O -rw-rw-r--
P arch/ppc/platforms/mpc82xx.h
------------------------------------------------

I0 42
/*
 * arch/ppc/platforms/mpc82xx.h
 *
 * Board specific support for various 82xx platforms.
 *
 * Author: Allen Curtis <acurtis@onz.com>
 *
 * Copyright 2002 Ones and Zeros, Inc.
 *
 * This program is free software; you can redistribute  it and/or modify it
 * under  the terms of  the GNU General  Public License as published by the
 * Free Software Foundation;  either version 2 of the  License, or (at your
 * option) any later version.
 */
#ifndef __CONFIG_82XX_PLATFORMS
#define __CONFIG_82XX_PLATFORMS
\
#ifdef CONFIG_8260
\
#ifdef CONFIG_EST8260
#include <platforms/est8260.h>
#endif
\
#ifdef CONFIG_SBS8260
#include <platforms/sbs8260.h>
#endif
\
#ifdef CONFIG_RPX6
#include <platforms/rpxsuper.h>
#endif
\
#ifdef CONFIG_WILLOW
#include <platforms/willow.h>
#endif
\
#ifdef CONFIG_TQM8260
#include <platforms/tqm8260.h>
#endif
\
#endif	/* CONFIG_8260 */
\
#endif

== arch/ppc/platforms/tqm8260_setup.c ==
New file: arch/ppc/platforms/tqm8260_setup.c
V 4

acurtis@ws01.onz.com|arch/ppc/platforms/tqm8260_setup.c|20021217160851|18068|37366f7bd3b0e553
D 1.0 02/12/17 08:08:51-08:00 acurtis@ws01.onz.com +0 -0
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
c BitKeeper file /misc/dual166/acurtis/dev/linux/est8260-ppc2.5/arch/ppc/platforms/tqm8260_setup.c
K 18068
P arch/ppc/platforms/tqm8260_setup.c
R 37366f7bd3b0e553
X 0x821
------------------------------------------------


acurtis@ws01.onz.com|arch/ppc/platforms/tqm8260_setup.c|20021217160851|18068|37366f7bd3b0e553
D 1.1 02/12/17 08:08:51-08:00 acurtis@ws01.onz.com +79 -0
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
F 1
K 29709
O -rw-rw-r--
P arch/ppc/platforms/tqm8260_setup.c
------------------------------------------------

I0 79
/*
 * arch/ppc/platforms/tqm8260_setup.c
 *
 * TQM8260 platform support
 *
 * Author: Allen Curtis <acurtis@onz.com>
 *
 * Copyright 2002 Ones and Zeros, Inc.
 *
 * This program is free software; you can redistribute  it and/or modify it
 * under  the terms of  the GNU General  Public License as published by the
 * Free Software Foundation;  either version 2 of the  License, or (at your
 * option) any later version.
 */
\
#include <linux/config.h>
#include <linux/seq_file.h>
\
#include <asm/immap_8260.h>
#include <asm/mpc8260.h>
#include <asm/machdep.h>
\
static void (*callback_setup_arch)(void);
\
extern unsigned char __res[sizeof(bd_t)];
\
extern void m8260_init(unsigned long r3, unsigned long r4,
	unsigned long r5, unsigned long r6, unsigned long r7);
\
static int
tqm8260_show_cpuinfo(struct seq_file *m)
{
	bd_t	*binfo = (bd_t *)__res;
\
	seq_printf(m, "vendor\t\t: IN2 Systems\n"
		      "machine\t\t: TQM8260 PowerPC\n"
		      "mem size\t\t: 0x%08x\n"
		      "\n",
		      binfo->bi_memsize);
	return 0;
}
\
static int
tqm8260_set_rtc_time(unsigned long time)
{
	((immap_t *)IMAP_ADDR)->im_sit.sit_tmcnt = time;
	((immap_t *)IMAP_ADDR)->im_sit.sit_tmcntsc = 0x3;
\
	return(0);
}
\
static unsigned long
tqm8260_get_rtc_time(void)
{
	return ((immap_t *)IMAP_ADDR)->im_sit.sit_tmcnt;
}
\
static void __init
tqm8260_setup_arch(void)
{
	printk("IN2 Systems TQM8260 port (C) 2002 Ones and Zeros, Inc. (support@onz.com)\n");
	callback_setup_arch();
}
\
void __init
platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
	      unsigned long r6, unsigned long r7)
{
	/* Generic 8260 platform initialization */
	m8260_init(r3, r4, r5, r6, r7);
\
	/* Anything special for this platform */
	ppc_md.show_cpuinfo	= tqm8260_show_cpuinfo;
	ppc_md.set_rtc_time	= tqm8260_set_rtc_time;
	ppc_md.get_rtc_time	= tqm8260_get_rtc_time;
\
	callback_setup_arch	= ppc_md.setup_arch;
	ppc_md.setup_arch	= tqm8260_setup_arch;
}

== arch/ppc/mm/pgtable.c ==
patch@athlon.transmeta.com|arch/ppc/mm/pgtable.c|20020205201138|16734|2cc7bfaab84a832
porter@cox.net|arch/ppc/mm/pgtable.c|20021106235145|60873
D 1.13 02/12/17 08:08:50-08:00 acurtis@ws01.onz.com +2 -0
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Added CONFIG_440 conditional
K 62708
O -rw-rw-r--
P arch/ppc/mm/pgtable.c
------------------------------------------------

I33 1
#ifdef CONFIG_440
I34 1
#endif

== arch/ppc/boot/simple/embed_config.c ==
paulus@tango.paulus.ozlabs.org|arch/ppc/boot/simple/embed_config.c|20020210110805|35004|c8486d19339b8bcb
dgibson@zax.zax|arch/ppc/boot/simple/embed_config.c|20021001040140|32505
D 1.13 02/12/17 08:08:49-08:00 acurtis@ws01.onz.com +1 -1
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Added CONFIG_TQM8260
K 35097
O -rw-rw-r--
P arch/ppc/boot/simple/embed_config.c
------------------------------------------------

D434 1
I434 1
#if defined(CONFIG_EST8260) || defined(CONFIG_TQM8260)

== arch/ppc/configs/TQM8260_defconfig ==
paulus@tango.paulus.ozlabs.org|arch/ppc/configs/TQM8260_defconfig|20020210111437|58304|a9f2bd198d4ee29c
aia21@cantab.net|arch/ppc/configs/TQM8260_defconfig|20020813014318|26289
D 1.4 02/12/17 08:08:50-08:00 acurtis@ws01.onz.com +155 -124
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Updated default config
K 62729
O -rw-rw-r--
P arch/ppc/configs/TQM8260_defconfig
------------------------------------------------

D4 2
I5 1
CONFIG_MMU=y
I6 1
CONFIG_HAVE_DEC_LOCK=y
I13 8
# General setup
#
CONFIG_NET=y
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
\
#
D17 1
I17 2
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODULE_FORCE_UNLOAD is not set
I23 1
CONFIG_PPC32=y
D25 1
I25 2
# CONFIG_40x is not set
# CONFIG_440 is not set
I27 6
# CONFIG_PPC_ISERIES is not set
\
#
# IBM 4xx options
#
CONFIG_EMBEDDEDBOOT=y
I28 1
CONFIG_PPC_STD_MMU=y
I30 2
# CONFIG_SBS8260 is not set
# CONFIG_RPX6 is not set
D32 2
I33 1
# CONFIG_WILLOW_1 is not set
D35 3
I37 1
# CONFIG_PREEMPT is not set
D43 4
D48 4
I51 1
# CONFIG_PC_KEYBOARD is not set
D57 1
D63 1
I63 16
# CONFIG_CMDLINE_BOOL is not set
\
#
# Advanced setup
#
# CONFIG_ADVANCED_OPTIONS is not set
\
#
# Default settings for advanced configuration options are used
#
CONFIG_HIGHMEM_START=0xfe000000
CONFIG_LOWMEM_SIZE=0x20000000
CONFIG_KERNEL_START=0xc0000000
CONFIG_TASK_SIZE=0x80000000
CONFIG_BOOT_LOAD=0x00400000
CONFIG_SWAP=y
D74 1
D80 5
D95 6
I100 19
\
#
# ATA/IDE/MFM/RLL support
#
# CONFIG_IDE is not set
\
#
# SCSI support
#
# CONFIG_SCSI is not set
\
#
# Fusion MPT device support
#
\
#
# I2O device support
#
# CONFIG_I2O is not set
D107 2
I112 1
# CONFIG_NET_KEY is not set
I116 1
# CONFIG_IP_PNP_DHCP is not set
I120 1
# CONFIG_ARPD is not set
I122 3
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_XFRM_USER is not set
D124 2
D128 1
I128 1
# SCTP Configuration (EXPERIMENTAL)
D130 2
I131 5
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC is not set
D136 1
D149 8
I156 1
# Network testing
D158 1
I158 1
# CONFIG_NET_PKTGEN is not set
D174 1
D180 4
I183 1
# CONFIG_CRC32 is not set
D186 1
D189 4
D198 4
D213 1
I213 1
# Token Ring devices (depends on LLC=y)
D215 1
D217 1
D238 6
I243 1
# CONFIG_ISDN_BOOL is not set
I253 5
# CONFIG_CD_NO_IDESCSI is not set
\
#
# Old CD-ROM drivers (not SCSI, not IDE)
#
D256 1
I256 1
# Input device support
I260 18
# Userland interfaces
#
\
#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
\
#
# Input Device Drivers
#
\
#
D268 2
D271 2
D275 1
I275 1
# Serial drivers
D277 1
I277 1
# CONFIG_SERIAL_8250 is not set
D280 1
I280 1
# Non-8250 serial port support
D282 2
I283 2
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=32
D286 1
I286 1
# I2C support
D288 1
I288 1
# CONFIG_I2C is not set
D291 1
I291 1
# Mice
I292 1
# CONFIG_BUSMOUSE is not set
D299 1
I301 1
# CONFIG_GEN_RTC is not set
D305 3
I314 1
# CONFIG_RAW_DRIVER is not set
D328 1
D330 1
I332 1
# CONFIG_BEFS_FS is not set
I333 2
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
D335 3
D339 1
D342 1
I342 1
CONFIG_RAMFS=y
D344 1
I344 1
# CONFIG_JFS_FS is not set
I345 1
# CONFIG_VXFS_FS is not set
D347 2
D352 2
D356 1
I358 1
# CONFIG_EXT2_FS_XATTR is not set
D360 1
D362 1
D364 1
I364 1
# CONFIG_XFS_FS is not set
I369 1
# CONFIG_INTERMEZZO_FS is not set
I371 1
# CONFIG_NFS_V4 is not set
D374 1
I376 2
# CONFIG_EXPORTFS is not set
# CONFIG_CIFS is not set
D379 8
I386 1
# CONFIG_AFS_FS is not set
I397 1
# CONFIG_LDM_PARTITION is not set
D401 2
I402 1
# CONFIG_EFI_PARTITION is not set
I407 3
# CONFIG_SCC_ENET is not set
CONFIG_FEC_ENET=y
# CONFIG_USE_MDIO is not set
D410 1
I410 1
# MPC8260 CPM Options
D412 2
I413 1
# CONFIG_SCC_CONSOLE is not set
D417 1
D420 1
I420 1
# Generic MPC8260 Options
D427 1
I427 9
\
#
# Bluetooth support
#
# CONFIG_BT is not set
\
#
# Library routines
#
D432 3
I434 11
# CONFIG_DEBUG_KERNEL is not set
\
#
# Security options
#
# CONFIG_SECURITY is not set
\
#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

== arch/ppc/platforms/Makefile ==
paulus@tango.paulus.ozlabs.org|arch/ppc/platforms/Makefile|20020210112152|00854|bcaddbb53429da46
paulus@samba.org|arch/ppc/platforms/Makefile|20021106223517|39060
D 1.16 02/12/17 08:08:50-08:00 acurtis@ws01.onz.com +2 -0
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Added platform specific setup.c files. (EST8260 and TQM8260)
K 45014
O -rw-rw-r--
P arch/ppc/platforms/Makefile
------------------------------------------------

I36 2
obj-$(CONFIG_EST8260)		+= est8260_setup.o
obj-$(CONFIG_TQM8260)		+= tqm8260_setup.o

== arch/ppc/platforms/tqm8260.h ==
paulus@tango.paulus.ozlabs.org|arch/ppc/platforms/tqm8260.h|20020210112152|55541|ee7331884ebfa3cf
paulus@tango.paulus.ozlabs.org|arch/ppc/platforms/tqm8260.h|20020210112153|22264
D 1.2 02/12/17 08:08:50-08:00 acurtis@ws01.onz.com +5 -3
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Added header include conditional
c Updated to include BOOTROM_RESTART_ADDR
K 26213
O -rw-rw-r--
P arch/ppc/platforms/tqm8260.h
------------------------------------------------

D7 2
I8 2
#ifndef __TQM8260_PLATFORM
#define __TQM8260_PLATFORM
D17 1
I17 3
#define BOOTROM_RESTART_ADDR	((uint)0x40000104)
\
#endif	/* __TQM8260_PLATFORM */

== arch/ppc/8260_io/enet.c ==
torvalds@athlon.transmeta.com|arch/ppc/8260_io/enet.c|20020205174026|10460|c6435561d2676f77
paulus@au1.ibm.com|arch/ppc/8260_io/enet.c|20020916062936|18537
D 1.8 02/12/17 08:08:49-08:00 acurtis@ws01.onz.com +1 -1
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Removed reference to request_8xxirq()
K 18241
O -rw-rw-r--
P arch/ppc/8260_io/enet.c
------------------------------------------------

D810 1
I810 1
	request_irq(SIU_INT_ENET, scc_enet_interrupt, 0, "enet", dev);

== arch/ppc/8260_io/fcc_enet.c ==
torvalds@athlon.transmeta.com|arch/ppc/8260_io/fcc_enet.c|20020205174026|12002|ccaf07782eab2409
paulus@samba.org|arch/ppc/8260_io/fcc_enet.c|20020916045156|24402
D 1.8 02/12/17 08:08:49-08:00 acurtis@ws01.onz.com +2 -2
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Removed reference to request_8xxirq()
K 23810
O -rw-rw-r--
P arch/ppc/8260_io/fcc_enet.c
------------------------------------------------

D1708 1
I1708 1
	if (request_irq(fip->fc_interrupt, fcc_enet_interrupt, 0,
D1713 1
I1713 1
	if (request_irq(PHY_INTERRUPT, mii_link_interrupt, 0,

== arch/ppc/8260_io/uart.c ==
torvalds@athlon.transmeta.com|arch/ppc/8260_io/uart.c|20020205174026|11166|c6dfa4adcc8b2a32
paulus@samba.org|arch/ppc/8260_io/uart.c|20020916045156|10939
D 1.10 02/12/17 08:08:49-08:00 acurtis@ws01.onz.com +16 -27
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Converted task_queues to work_queues
c Fixup device related macros
c Replaced request_8xxirq() with request_irq()
c General cleanup
K 559
O -rw-rw-r--
P arch/ppc/8260_io/uart.c
------------------------------------------------

I5 2
 *  Copyright (c) 2002 Allen Curtis, Ones and Zeros, Inc. (acurtis@onz.com)
 *	2.5.50 updates
I30 1
#include <linux/workqueue.h>
D72 3
I74 1
static char *serial_version = "0.02";
D204 2
I205 2
	struct work_struct	tqueue;
	struct work_struct	tqueue_hangup;
D334 2
I335 1
	schedule_work(&info->tqueue);
D482 1
I482 1
	schedule_delayed_work(&tty->flip.work, 1);
D540 1
I540 1
			if (schedule_work(&info->tqueue_hangup) == 0)
D631 5
D654 1
I654 1
 * This routine is called from the scheduler work queue when the interrupt
D1759 1
I1759 1
		char_time = min(char_time, (unsigned long)timeout);
D1983 1
I1983 1
	line = minor(tty->device) - tty->driver.minor_start;
D2458 1
I2458 1
	return mk_kdev(TTY_MAJOR, 64 + c->index);
D2506 2
D2683 4
I2686 2
			INIT_WORK(&info->tqueue, do_softint, info);
			INIT_WORK(&info->tqueue_hangup, do_serial_hangup, info);
D2877 1
I2877 1
			request_irq(state->irq, rs_8xx_interrupt, 0, "uart", info);
D2913 2

== arch/ppc/configs/est8260_defconfig ==
torvalds@athlon.transmeta.com|arch/ppc/configs/est8260_defconfig|20020205174025|33303|a4b94eb0f03bd339
maxk@qualcomm.com|arch/ppc/configs/est8260_defconfig|20021016113035|24226
D 1.14 02/12/17 08:08:50-08:00 acurtis@ws01.onz.com +138 -229
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Updated default config
K 24055
O -rw-rw-r--
P arch/ppc/configs/est8260_defconfig
------------------------------------------------

D4 2
I5 1
CONFIG_MMU=y
I6 1
CONFIG_HAVE_DEC_LOCK=y
I13 8
# General setup
#
CONFIG_NET=y
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
\
#
D16 1
I16 4
CONFIG_MODULES=y
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_KMOD is not set
D24 1
I24 2
# CONFIG_40x is not set
# CONFIG_440 is not set
I26 6
# CONFIG_PPC_ISERIES is not set
\
#
# IBM 4xx options
#
CONFIG_EMBEDDEDBOOT=y
I30 4
# CONFIG_SBS8260 is not set
# CONFIG_RPX6 is not set
# CONFIG_TQM8260 is not set
# CONFIG_WILLOW_1 is not set
I31 1
# CONFIG_PREEMPT is not set
D37 4
D42 4
I45 1
# CONFIG_PC_KEYBOARD is not set
D51 1
D57 1
I60 14
# Advanced setup
#
CONFIG_ADVANCED_OPTIONS=y
CONFIG_HIGHMEM_START=0xfe000000
CONFIG_LOWMEM_SIZE=0x20000000
# CONFIG_KERNEL_START_BOOL is not set
CONFIG_KERNEL_START=0xc0000000
# CONFIG_TASK_SIZE_BOOL is not set
CONFIG_TASK_SIZE=0x80000000
# CONFIG_BOOT_LOAD_BOOL is not set
CONFIG_BOOT_LOAD=0x00400000
CONFIG_SWAP=y
\
#
D69 1
D75 5
D90 7
I96 19
\
#
# ATA/IDE/MFM/RLL support
#
# CONFIG_IDE is not set
\
#
# SCSI support
#
# CONFIG_SCSI is not set
\
#
# Fusion MPT device support
#
\
#
# I2O device support
#
# CONFIG_I2O is not set
D103 2
I108 1
# CONFIG_NET_KEY is not set
I118 1
# CONFIG_ARPD is not set
I120 3
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_XFRM_USER is not set
D122 3
D127 1
I127 1
# SCTP Configuration (EXPERIMENTAL)
D129 2
I130 5
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC is not set
D135 1
D148 8
I155 1
# Network testing
D157 1
I157 1
# CONFIG_NET_PKTGEN is not set
D178 8
I185 2
# CONFIG_CRC32 is not set
# CONFIG_OAKNET is not set
D187 1
D190 2
D197 7
D206 1
D216 1
I216 1
# Token Ring devices (depends on LLC=y)
D218 1
D220 1
D241 6
I246 1
# CONFIG_ISDN_BOOL is not set
I256 5
# CONFIG_CD_NO_IDESCSI is not set
\
#
# Old CD-ROM drivers (not SCSI, not IDE)
#
D259 1
I259 1
# Input device support
D262 4
I265 15
\
#
# Userland interfaces
#
\
#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
# CONFIG_SERIO is not set
\
#
# Input Device Drivers
#
D275 2
D278 7
D287 1
I287 1
# Serial drivers
D289 2
I290 1
# CONFIG_SERIAL_8250 is not set
D293 1
I293 1
# Non-8250 serial port support
D295 1
I295 2
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
D298 1
I298 1
# I2C support
I299 1
# CONFIG_I2C is not set
D302 1
I302 1
# Mice
I303 1
# CONFIG_BUSMOUSE is not set
D310 1
I312 1
# CONFIG_GEN_RTC is not set
I322 1
# CONFIG_RAW_DRIVER is not set
D336 1
D338 1
I340 1
# CONFIG_BEFS_FS is not set
I341 2
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
D343 3
D347 2
D351 1
I351 1
CONFIG_RAMFS=y
D353 1
I353 1
# CONFIG_JFS_FS is not set
D357 2
D362 2
D366 1
I368 1
# CONFIG_EXT2_FS_XATTR is not set
D371 1
D373 1
I373 1
# CONFIG_XFS_FS is not set
I378 1
# CONFIG_INTERMEZZO_FS is not set
I380 1
# CONFIG_NFS_V4 is not set
D383 1
I385 2
# CONFIG_EXPORTFS is not set
# CONFIG_CIFS is not set
D388 8
I395 1
# CONFIG_AFS_FS is not set
D400 13
I412 2
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
D418 4
D423 1
D425 34
D461 1
I461 1
# MPC8260 CPM Options
I462 1
# CONFIG_SCC_CONSOLE is not set
D465 14
I478 1
# Generic MPC8260 Options
I479 1
# CONFIG_DCACHE_DISABLE is not set
D482 1
I482 1
# USB support
D484 5
D491 1
I491 1
# Bluetooth support
D493 1
I493 1
# CONFIG_BT is not set
D496 1
I496 1
# Library routines
D498 25
D525 1
I525 1
# Kernel hacking
D527 1
I527 1
# CONFIG_DEBUG_KERNEL is not set
D530 1
I530 1
# Security options
D532 1
I532 1
# CONFIG_SECURITY is not set
D535 1
I535 1
# Cryptographic options
D537 3
I539 1
# CONFIG_CRYPTO is not set

== arch/ppc/syslib/m8260_setup.c ==
torvalds@athlon.transmeta.com|arch/ppc/kernel/m8260_setup.c|20020205174025|51000|f1612ef7c8f2ae4b
porter@cox.net|arch/ppc/syslib/m8260_setup.c|20021105215307|04223
D 1.17 02/12/17 08:08:50-08:00 acurtis@ws01.onz.com +35 -47
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Converted this to provide default platform functionality. (no conditionals)
c Restart expects BOOTROM_RESTART_ADDR but will provide a default.
c power_off() and halt() now halt.
c Removed request_irq() stub.
c Misc cleanup.
K 51660
O -rw-rw-r--
P arch/ppc/syslib/m8260_setup.c
------------------------------------------------

D66 10
D96 1
I96 1
static int
D99 4
D104 1
I104 1
\
D111 3
D117 1
I119 5
#ifndef BOOTROM_RESTART_ADDR
#warning "Using default BOOTROM_RESTART_ADDR!"
#define BOOTROM_RESTART_ADDR	0xff000104
#endif
\
D130 5
I134 1
	startaddr = BOOTROM_RESTART_ADDR;
D140 1
I140 1
	m8260_gorom((void*)__pa(__res), startaddr);
D144 1
I144 1
m8260_halt(void)
D146 1
I146 2
	local_irq_disable();
	while (1);
D150 1
I150 1
m8260_power_off(void)
D152 1
I152 1
	m8260_halt();
D155 1
D184 3
D197 1
D222 3
I224 1
	uint addr;
I225 19
	/* Map IMMR region to a 256MB BAT */
	addr = (immr != NULL) ? (uint)immr : IMAP_ADDR;
	io_block_mapping(addr, addr, 0x10000000, _PAGE_IO);
\
	/* Map I/O region to a 256MB BAT */
	io_block_mapping(IO_VIRT_ADDR, IO_PHYS_ADDR, 0x10000000, _PAGE_IO);
}
\
/* Inputs:
 *   r3 - Optional pointer to a board information structure.
 *   r4 - Optional pointer to the physical starting address of the init RAM
 *        disk.
 *   r5 - Optional pointer to the physical ending address of the init RAM
 *        disk.
 *   r6 - Optional pointer to the physical starting address of any kernel
 *        command-line parameters.
 *   r7 - Optional pointer to the physical ending address of any kernel
 *        command-line parameters.
 */
D227 1
I227 1
m8260_init(unsigned long r3, unsigned long r4, unsigned long r5,
D268 8

== arch/ppc/kernel/ppc_ksyms.c ==
torvalds@athlon.transmeta.com|arch/ppc/kernel/ppc_ksyms.c|20020205174025|24555|ed26bb10e68d159b
paulus@samba.org|arch/ppc/kernel/ppc_ksyms.c|20021107113247|35625
D 1.36 02/12/17 08:08:50-08:00 acurtis@ws01.onz.com +1 -1
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Removed request_8xxirq() export for 8260
K 33772
O -rw-rw-r--
P arch/ppc/kernel/ppc_ksyms.c
------------------------------------------------

D338 1
I338 1
#if defined(CONFIG_8xx)

== arch/ppc/mm/init.c ==
torvalds@athlon.transmeta.com|arch/ppc/mm/init.c|20020205174024|33660|9e754c1b56624c1c
paulus@samba.org|arch/ppc/mm/init.c|20021107113247|35196
D 1.32 02/12/17 08:08:50-08:00 acurtis@ws01.onz.com +2 -0
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Added CONFIG_440 conditional
K 37031
O -rw-rw-r--
P arch/ppc/mm/init.c
------------------------------------------------

I46 1
#ifdef CONFIG_440
I47 1
#endif

== arch/ppc/platforms/est8260.h ==
torvalds@athlon.transmeta.com|include/asm-ppc/est8260.h|20020205173950|11533|1f594fa3c867fc1
paulus@au1.ibm.com|arch/ppc/platforms/est8260.h|20020916062938|14942
D 1.6 02/12/17 08:08:50-08:00 acurtis@ws01.onz.com +6 -1
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Added header include conditional
c Updated to include BOOTROM_RESTART_ADDR
K 24774
O -rw-rw-r--
P arch/ppc/platforms/est8260.h
------------------------------------------------

I5 2
#ifndef __EST8260_PLATFORM
#define __EST8260_PLATFORM
D7 1
I7 3
#define IMAP_ADDR		((uint)0xf0000000)
\
#define BOOTROM_RESTART_ADDR	((uint)0xff000104)
I27 1
#endif 	/* __EST8260_PLATFORM */

== include/asm-ppc/mpc8260.h ==
torvalds@athlon.transmeta.com|include/asm-ppc/mpc8260.h|20020205173950|12837|c28125d81075883e
paulus@samba.org|include/asm-ppc/mpc8260.h|20020916045205|44122
D 1.5 02/12/17 08:08:50-08:00 acurtis@ws01.onz.com +15 -31
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Now includes platforms/mpc82xx.h instead of including each platform header.
c Provides default macro definitions for address mapping, etc if not specified
c by the platform specific header.
c Removed request_8xxirq() stuffs.
K 17971
O -rw-rw-r--
P include/asm-ppc/mpc8260.h
------------------------------------------------

I11 1
#include <platforms/mpc82xx.h>
D13 4
I16 4
/* Make sure the memory translation stuff is there if PCI not used.
 */
#ifndef _IO_BASE
#define _IO_BASE        0
D19 2
I20 2
#ifndef _ISA_MEM_BASE
#define _ISA_MEM_BASE   0
D23 2
I24 2
#ifndef PCI_DRAM_OFFSET
#define PCI_DRAM_OFFSET 0
D27 2
I28 4
/* Map 256MB I/O region
 */
#ifndef IO_PHYS_ADDR
#define IO_PHYS_ADDR	0xe0000000
D30 3
I32 2
#ifndef IO_VIRT_ADDR
#define IO_VIRT_ADDR	IO_PHYS_ADDR
D35 7
D47 11

# Patch checksum=9b01460e
--0-235934558-1045085227=:37365--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
