Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F162EDDE27
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Oct 2007 08:28:48 +1000 (EST)
Message-ID: <4705691A.9020509@freescale.com>
Date: Thu, 04 Oct 2007 17:28:42 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>,
	PowerPC dev list <linuxppc-dev@ozlabs.org>
Subject: include/asm/cpm2.h:14:21: error: asm/cpm.h: No such file or directory
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar, this is what I get when I compile your 2.6.24 branch for the 8610:

   CC      arch/powerpc/sysdev/fsl_soc.o
In file included from arch/powerpc/sysdev/fsl_soc.c:40:
include/asm/cpm2.h:14:21: error: asm/cpm.h: No such file or directory
make[1]: *** [arch/powerpc/sysdev/fsl_soc.o] Error 1
make: *** [arch/powerpc/sysdev] Error 2

Commenting out the "#include <asm/cpm.h>" in cpm2.h makes the compilation 
failure go away, but I don't know if that's the proper fix, since the 8610 
doesn't have a CPM.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
