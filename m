Return-Path: <rodolfo@lesc.ufc.br>
Received: from lesc0.lesc.ufc.br (unknown [200.17.37.126])
	by ozlabs.org (Postfix) with ESMTP id 27258DE5F0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Apr 2008 05:15:47 +1000 (EST)
MIME-Version: 1.0
Date: Thu, 17 Apr 2008 16:15:43 -0300
From: rodolfo <rodolfo@lesc.ufc.br>
To: Grant Likely <grant.likely@secretlab.ca>,
	Linuxppc embedded <linuxppc-embedded@ozlabs.org>
Subject: problems with 'XPAR_PLB_CLOCK_FREQ_HZ'.
Message-ID: <75c089d6de2ba74b5fdbf6a6fd91e468@lesc.ufc.br>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, everybody,

my xparameters_ml300.h does not include 'XPAR_PLB_CLOCK_FREQ_HZ'.


  CC      arch/ppc/boot/simple/embed_config.o
arch/ppc/boot/simple/embed_config.c: In function 'embed_config':
arch/ppc/boot/simple/embed_config.c:781: error: 'XPAR_PLB_CLOCK_FREQ_HZ'
undeclared (first use in this function)
arch/ppc/boot/simple/embed_config.c:781: error: (Each undeclared identifier
is reported only once
arch/ppc/boot/simple/embed_config.c:781: error: for each function it
appears in.)
make[2]: ** [arch/ppc/boot/simple/embed_config.o] Erro 1
make[1]: ** [simple] Erro 2
make: ** [zImage] Erro 2



Can I replace 'XPAR_PLB_CLOCK_FREQ_HZ' for XPAR_CORE_CLOCK_FREQ_HZ/3
knowing that my MHS file description is:


# Processor clock frequency: 300.000000 MHz
# Bus clock frequency: 100.000000 MHz


MHS FILE:
#
##############################################################################
# Created by Base System Builder Wizard for Xilinx EDK 9.1 Build EDK_J.19
# Thu Apr  3 17:07:17 2008
# Target Board:  Xilinx XUP Virtex-II Pro Development System Rev C
# Family:	 virtex2p
# Device:	 xc2vp30
# Package:	 ff896
# Speed Grade:	 -7
# Processor: PPC 405
# Processor clock frequency: 300.000000 MHz
# Bus clock frequency: 100.000000 MHz
# Debug interface: FPGA JTAG
# On Chip Memory : 128 KB
# Total Off Chip Memory : 512 MB
# - DDR_SDRAM_64Mx64 Dual Rank = 256 MB
# - DDR_512MB_64Mx64_rank2_row13_col10_cl2_5 = 256 MB
#
##############################################################################

regards,
rodolfo
