Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B0DB1B7B65
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Dec 2009 17:09:21 +1100 (EST)
Subject: Build failure with fsl_msi.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 08 Dec 2009 17:09:14 +1100
Message-ID: <1260252554.16132.1.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The ppc64e_defconfig gives me that:

No big deal since nothing currently uses Book3E HW with fsl_msi but
probably something you should fix.

cc1: warnings being treated as errors
/home/benh/linux-powerpc-test/arch/powerpc/sysdev/fsl_msi.c: In function ‘fsl_msi_cascade’:
/home/benh/linux-powerpc-test/arch/powerpc/sysdev/fsl_msi.c:189: error: cast from pointer to integer of different size
  LDS     arch/powerpc/kernel/vdso32/vdso32.lds
/home/benh/linux-powerpc-test/arch/powerpc/sysdev/fsl_msi.c: In function ‘fsl_of_msi_probe’:
/home/benh/linux-powerpc-test/arch/powerpc/sysdev/fsl_msi.c:307: error: cast to pointer from integer of different size
make[2]: *** [arch/powerpc/sysdev/fsl_msi.o] Error 1

Cheers,
Ben.
