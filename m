Return-Path: <bounces@nabble.com>
Received: from talk.nabble.com (www.nabble.com [72.21.53.35])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0C3F5DDFCE
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 May 2007 02:12:17 +1000 (EST)
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50) id 1HjHR7-0002yq-45
	for linuxppc-embedded@ozlabs.org; Wed, 02 May 2007 09:12:13 -0700
Message-ID: <10289144.post@talk.nabble.com>
Date: Wed, 2 May 2007 09:12:13 -0700 (PDT)
From: Guillaume Berthelom <guillaume.berthelom@cleode.fr>
To: linuxppc-embedded@ozlabs.org
Subject: problem to load uImage but not zImage (on virtex-4 base board)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


hi,

I'm trying to port Linux 2.6 on Avnet FX12 MM board with U-Boot and the help
of xilinx ML403 config.

I have generate my costum xparameters.h file with EDK 8.2i.
I use ELDK 4.1 and Linux 2.6.20.x.
I have modified ml403.h u-boot's config file to adapt it for my board and I
have no problem to boot u-boot.
I use the right board_info structure from <asm/ppcboot.h> and not the one in
xilinx_ml403.h.

When I load the zImage directly with xilinx xmd debugger, the kernel start
without problem (if I don't have KGDB or SERIAL_TEXT_DEBUG option in my
kernel config). But when I try to load the uImage with u-boot, the kernel
start but crach befor I can see something on output.
The kernel start because I debug it and the platform_init is ok, setup_arch
too and it crach after ppc4xx_setup_arch at  printk(KERN_INFO "Xilinx ML403
Reference System (Virtex-4 FX)\n") line  when the kernel access in printk.c. 

I use the opb_uart16550 IP in my Xilinx design and the associat drivers in
u-boot and linux.

I'm new in linux embedded and I'm in internship...I have any idea where and
what is the problem, certanly in the serial int I guest but I'm not sure.

Thanks and sorry for my english I'm fench.
Guillaume Berthelom

-- 
View this message in context: http://www.nabble.com/problem-to-load-uImage-but-not-zImage-%28on-virtex-4-base-board%29-tf3681533.html#a10289144
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
