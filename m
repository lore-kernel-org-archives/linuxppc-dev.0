Return-Path: <philn@avalon.com.au>
Subject: mv64x60 DMA controller
From: Phil Nitschke <philn@avalon.com.au>
To: linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 14:33:21 +0930
Message-Id: <1150175001.10252.30.camel@lamorak.int.avalon.com.au>
Mime-Version: 1.0
Reply-To: Phil.Nitschke@avalon.com.au
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi guys,

I've written a DMA controller driver for the Marvell Discovery series
(particularly the MV64360, MV64460).  It is still a work-in-progress and
comes with many caveats, but I'm happy to share it should anyone be
interested.  Some of the caveats include:
  - does not support scatter-gather operations yet
  - quite limited testing has been performed to date

The 50 kb, 5000 line patch is usually applied to a 2.6.16 kernel which
has already been patched for use with Artesyn boards, particularly the
PmPPC7448, and affects the following files:

        linux-2.6.16/arch/ppc/Kconfig
        linux-2.6.16/arch/ppc/configs/pmppc744x_defconfig
        linux-2.6.16/arch/ppc/platforms/pmppc7447.c
        linux-2.6.16/arch/ppc/syslib/Makefile
        linux-2.6.16/arch/ppc/syslib/mv64x60.c
        linux-2.6.16/arch/ppc/syslib/mv64x6x_dma.c
        linux-2.6.16/include/asm-ppc/mv64x60.h
        linux-2.6.16/include/asm-ppc/mv64x60_defs.h
        linux-2.6.16/include/asm-ppc/mv64x6x_dma.h
        linux-2.6.16/include/linux/mv643xx.h
        
Please let me know if there is anyone would like me to post this patch,
and in what form I should do this.

-- 
Phil
