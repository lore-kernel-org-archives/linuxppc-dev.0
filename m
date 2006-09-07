Return-Path: <aidan@nicta.com.au>
Received: from muse.redundamoto.com
	(c220-237-11-187.randw1.nsw.optusnet.com.au [220.237.11.187])
	by ozlabs.org (Postfix) with ESMTP id 6D97D679FB
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Sep 2006 22:18:01 +1000 (EST)
Message-ID: <450007B2.4010508@nicta.com.au>
Date: Thu, 07 Sep 2006 21:51:14 +1000
From: Aidan Williams <aidan@nicta.com.au>
MIME-Version: 1.0
To: Simon Jung <palasim@gmx.de>
Subject: Re: uCLinux for PPC: Bug in autoconf.h creation
References: <44FFE5C9.2070203@gmx.de>
In-Reply-To: <44FFE5C9.2070203@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I would suspect CRLF issues..

Try running dos2unix on your
  arch/ppc/platforms/xilinx_auto/auto-config.in
and then defaulting all your settings with make menuconfig to regenerate your kernel .config and config headers.

- aidan


Simon Jung wrote:
> I am trying to build a uCLinux Distribution for PowerPC following the 
> instructions on
> 
> http://www.itee.uq.edu.au/~jwilliams/mblaze-uclinux/uclinux_powerpc/ 
> <http://www.itee.uq.edu.au/%7Ejwilliams/mblaze-uclinux/uclinux_powerpc/>
> 
> "make menuconfig" works well  but the created file 
> /linuxppx-2.4.x/include/linux/autoconf.h has errors:
> 
> The created "#defines" for integer and string types are mistyped the 
> closing bracket / quote is written into a newline.
> Example:
> 
> #define CONFIG_XILINX_PPC405_0_DISABLE_OPERAND_FORWARDING (1
> )
> #define CONFIG_XILINX_PPC405_0_DETERMINISTIMULT (0
> )
> #define CONFIG_XILINX_PPC405_0_MMU_ENABLE (1
> )
> #define CONFIG_XILINX_PPC405_0_DCR_RESYNC (0
> )
> #define CONFIG_XILINX_PPC405_0_INSTANCE "ppc405_0
> "
> #define CONFIG_XILINX_PPC405_0_HW_VER "2.00.c
> "
> #define CONFIG_XILINX_ON1_DMA_MASTER_0_INSTANCE "on1_dma_master_PPC
> "
> 
> How can I correct the generation of  autoconf.h ?
> 
> Greetings,
> Simon Jung
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
