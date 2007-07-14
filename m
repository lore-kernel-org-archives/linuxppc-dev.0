Return-Path: <rpjday@mindspring.com>
Received: from rubicon.netdirect.ca (nic.NetDirect.CA [216.16.235.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0E9AEDDD0D
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Jul 2007 08:22:52 +1000 (EST)
Received: from [192.168.1.102]
	(CPE0018396a01fc-CM001225dbafb6.cpe.net.cable.rogers.com
	[72.143.66.27]) (authenticated bits=0)
	by rubicon.netdirect.ca (8.13.1/8.13.1) with ESMTP id l6EMHWCw009208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jul 2007 18:17:40 -0400
Date: Sat, 14 Jul 2007 18:15:51 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Linux PPC Mailing List <linuxppc-dev@ozlabs.org>
Subject: possibly dead CONFIG-related content in arch/ppc
Message-ID: <Pine.LNX.4.64.0707141813300.9604@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


  from the most recent pull of the git tree, the output of my script
to find possibly dead content in the tree based on variables that
aren't defined in any Kconfig file anywhere in the entire tree.  feel
free to do with this as you wish.

========== ADS8260 ==========
arch/ppc/boot/simple/m8260_tty.c:53:#ifdef CONFIG_ADS8260
arch/ppc/boot/simple/embed_config.c:680:#ifdef CONFIG_ADS8260
arch/ppc/8260_io/fcc_enet.c:295:#elif defined(CONFIG_EST8260) || defined(CONFIG_ADS8260) || defined(CONFIG_PQ2FADS)
========== BOOTIMG ==========
arch/ppc/platforms/ev64360.c:26:#ifdef CONFIG_BOOTIMG
arch/ppc/platforms/katana.c:30:#ifdef CONFIG_BOOTIMG
========== DEBUG_BRINGUP ==========
arch/ppc/platforms/4xx/redwood5.c:67:#ifdef CONFIG_DEBUG_BRINGUP
========== FB_RPX ==========
arch/ppc/syslib/m8xx_setup.c:114:#ifdef CONFIG_FB_RPX
arch/ppc/syslib/m8xx_setup.c:416:#if defined(CONFIG_RPXTOUCH) || defined(CONFIG_FB_RPX)
========== FEC_PACKETHOOK ==========
arch/ppc/8xx_io/fec.c:47:#ifdef CONFIG_FEC_PACKETHOOK
arch/ppc/8xx_io/fec.c:187:#ifdef CONFIG_FEC_PACKETHOOK
arch/ppc/8xx_io/fec.c:203:#ifdef CONFIG_FEC_PACKETHOOK
arch/ppc/8xx_io/fec.c:283:#ifdef CONFIG_FEC_PACKETHOOK
arch/ppc/8xx_io/fec.c:340:#endif /* CONFIG_FEC_PACKETHOOK */
arch/ppc/8xx_io/fec.c:480:#ifdef CONFIG_FEC_PACKETHOOK
arch/ppc/8xx_io/fec.c:500:#ifdef CONFIG_FEC_PACKETHOOK
arch/ppc/8xx_io/fec.c:512:#ifdef CONFIG_FEC_PACKETHOOK
arch/ppc/8xx_io/fec.c:533:#ifdef CONFIG_FEC_PACKETHOOK
arch/ppc/8xx_io/fec.c:568:#ifdef CONFIG_FEC_PACKETHOOK
arch/ppc/8xx_io/fec.c:614:#ifdef CONFIG_FEC_PACKETHOOK
arch/ppc/8xx_io/fec.c:631:#ifdef CONFIG_FEC_PACKETHOOK
arch/ppc/8xx_io/fec.c:695:#ifdef CONFIG_FEC_PACKETHOOK
arch/ppc/8xx_io/fec.c:756:#ifdef CONFIG_FEC_PACKETHOOK
arch/ppc/8xx_io/fec.c:1691:#ifdef CONFIG_FEC_PACKETHOOK
========== KGDB_MPSC ==========
arch/ppc/platforms/cpci690.c:404:#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB_MPSC)
arch/ppc/platforms/cpci690.c:443:#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB_MPSC)
arch/ppc/platforms/cpci690.c:449:#endif	/* defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB_MPSC) */
========== KUP4K ==========
arch/ppc/platforms/tqm8xx.h:28:#ifndef CONFIG_KUP4K
arch/ppc/platforms/tqm8xx.h:31:#else	/* CONFIG_KUP4K */
arch/ppc/platforms/tqm8xx.h:48:#endif	/* CONFIG_KUP4K */
========== MV64360 ==========
arch/ppc/configs/ev64360_defconfig:115:CONFIG_MV64360=y
arch/ppc/configs/radstone_ppc7d_defconfig:117:CONFIG_MV64360=y
arch/ppc/configs/hdpu_defconfig:114:CONFIG_MV64360=y
arch/ppc/configs/chestnut_defconfig:113:CONFIG_MV64360=y
arch/ppc/configs/katana_defconfig:123:CONFIG_MV64360=y
arch/ppc/boot/simple/mv64x60_tty.c:108:#ifdef CONFIG_MV64360
arch/ppc/syslib/Makefile:55:obj-$(CONFIG_MV64360)		+= mv64360_pic.o
========== MV64360_SRAM_CACHE_COHERENT ==========
arch/ppc/platforms/hdpu.c:162:	 * Cache coherent write back, if CONFIG_MV64360_SRAM_CACHE_COHERENT set
arch/ppc/platforms/hdpu.c:168:#ifdef CONFIG_MV64360_SRAM_CACHE_COHERENT
========== NETTA ==========
arch/ppc/syslib/m8xx_setup.c:425:#if defined(CONFIG_NETTA)
drivers/net/fec_8xx/Makefile:10:ifeq ($(CONFIG_NETTA),y)
========== RPXTOUCH ==========
arch/ppc/syslib/m8xx_setup.c:416:#if defined(CONFIG_RPXTOUCH) || defined(CONFIG_FB_RPX)
========== SERIAL_CPM_ALT_SMC2 ==========
arch/ppc/configs/TQM850L_defconfig:317:CONFIG_SERIAL_CPM_ALT_SMC2=y
arch/ppc/configs/TQM823L_defconfig:317:CONFIG_SERIAL_CPM_ALT_SMC2=y
arch/ppc/configs/FADS_defconfig:316:# CONFIG_SERIAL_CPM_ALT_SMC2 is not set
arch/ppc/platforms/mpc885ads_setup.c:353:#ifndef CONFIG_SERIAL_CPM_ALT_SMC2
arch/ppc/platforms/mpc866ads_setup.c:237:#ifndef CONFIG_SERIAL_CPM_ALT_SMC2
drivers/serial/cpm_uart/cpm_uart_core.c:960:#ifdef CONFIG_SERIAL_CPM_ALT_SMC2
========== SERIAL_DETECT_IRQ ==========
arch/ppc/platforms/ev64260.h:110:#ifdef CONFIG_SERIAL_DETECT_IRQ
arch/ppc/platforms/85xx/sbc8560.h:30:#ifdef CONFIG_SERIAL_DETECT_IRQ
arch/ppc/platforms/pal4_serial.h:21:#ifdef CONFIG_SERIAL_DETECT_IRQ
arch/ppc/platforms/sandpoint.h:61:#ifdef CONFIG_SERIAL_DETECT_IRQ
arch/ppc/platforms/lopec.h:22:#ifdef CONFIG_SERIAL_DETECT_IRQ
arch/ppc/platforms/chestnut.h:112:#ifdef CONFIG_SERIAL_DETECT_IRQ
arch/ppc/platforms/radstone_ppc7d.h:148:#ifdef CONFIG_SERIAL_DETECT_IRQ
arch/i386/kernel/legacy_serial.c:18:#ifdef CONFIG_SERIAL_DETECT_IRQ
drivers/serial/8250.c:83:#define CONFIG_SERIAL_DETECT_IRQ 1
include/asm-ppc/pc_serial.h:29:#ifdef CONFIG_SERIAL_DETECT_IRQ
include/asm-alpha/serial.h:16:#ifdef CONFIG_SERIAL_DETECT_IRQ
include/asm-m68k/serial.h:20:#ifdef CONFIG_SERIAL_DETECT_IRQ
========== SERIAL_MANY_PORTS ==========
arch/ppc/syslib/ppc83xx_setup.h:45:#ifdef CONFIG_SERIAL_MANY_PORTS
arch/ppc/syslib/ppc85xx_setup.h:43:#ifdef CONFIG_SERIAL_MANY_PORTS
arch/ppc/platforms/ev64260.h:104:#ifdef CONFIG_SERIAL_MANY_PORTS
arch/ppc/platforms/85xx/sbc8560.h:21:#ifdef CONFIG_SERIAL_MANY_PORTS
arch/ppc/platforms/chestnut.h:103:#ifdef CONFIG_SERIAL_MANY_PORTS
drivers/serial/8250.c:86:#define CONFIG_SERIAL_MANY_PORTS 1
include/asm-ppc/pc_serial.h:22:#ifdef CONFIG_SERIAL_MANY_PORTS
========== SMP_750 ==========
arch/ppc/mm/tlb.c:92:#ifdef CONFIG_SMP_750
arch/powerpc/mm/tlb_32.c:92:#ifdef CONFIG_SMP_750
========== UART0_TTYS2 ==========
arch/ppc/platforms/4xx/ibmstb4.h:108:#if defined(CONFIG_UART0_TTYS2)
arch/ppc/platforms/4xx/ibmstbx25.h:125:#if defined(CONFIG_UART0_TTYS2)

rday
-- 
========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

http://fsdev.net/wiki/index.php?title=Main_Page
========================================================================
