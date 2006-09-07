Return-Path: <palasim@gmx.de>
Received: from mailgate1.uni-kl.de (mailgate1.uni-kl.de [131.246.120.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.uni-kl.de",
	Issuer "RHRK-CA Classic - G01" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1E69D67BA1
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Sep 2006 19:32:58 +1000 (EST)
Received: from [10.0.0.52] (fwbobda.informatik.uni-kl.de [131.246.167.20])
	by mailgate1.uni-kl.de (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id
	k879QjY4031420
	for <linuxppc-embedded@ozlabs.org>; Thu, 7 Sep 2006 11:26:45 +0200
Message-ID: <44FFE5D3.8000301@gmx.de>
Date: Thu, 07 Sep 2006 11:26:43 +0200
From: Simon Jung <palasim@gmx.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: uCLinux for PPC: Bug in autoconf.h creation
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am trying to build a uCLinux Distribution for PowerPC following the 
instructions on

http://www.itee.uq.edu.au/~jwilliams/mblaze-uclinux/uclinux_powerpc/ 
<http://www.itee.uq.edu.au/%7Ejwilliams/mblaze-uclinux/uclinux_powerpc/>

"make menuconfig" works well  but the created file 
/linuxppx-2.4.x/include/linux/autoconf.h has errors:

The created "#defines" for integer and string types are mistyped the 
closing bracket / quote is written into a newline.
Example:

#define CONFIG_XILINX_PPC405_0_DISABLE_OPERAND_FORWARDING (1
)
#define CONFIG_XILINX_PPC405_0_DETERMINISTIMULT (0
)
#define CONFIG_XILINX_PPC405_0_MMU_ENABLE (1
)
#define CONFIG_XILINX_PPC405_0_DCR_RESYNC (0
)
#define CONFIG_XILINX_PPC405_0_INSTANCE "ppc405_0
"
#define CONFIG_XILINX_PPC405_0_HW_VER "2.00.c
"
#define CONFIG_XILINX_ON1_DMA_MASTER_0_INSTANCE "on1_dma_master_PPC
"

How can I correct the generation of  autoconf.h ?

Greetings,
Simon Jung
