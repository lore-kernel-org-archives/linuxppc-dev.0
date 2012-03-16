Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 16146B6FC5
 for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2012 06:39:53 +1100 (EST)
Subject: Re: [PATCH][v2] powerpc/85xx: Fix compiler error with THIS_MODULE and
 related
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1328115915-16172-1-git-send-email-claudiu.manoil@freescale.com>
Date: Fri, 16 Mar 2012 14:38:29 -0500
Message-Id: <38E15FD5-4C6F-487B-8002-7A4D10525B3D@kernel.crashing.org>
References: <1328115915-16172-1-git-send-email-claudiu.manoil@freescale.com>
To: Claudiu Manoil <claudiu.manoil@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 1, 2012, at 11:05 AM, Claudiu Manoil wrote:

> CC      arch/powerpc/sysdev/fsl_85xx_l2ctlr.o
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:209:13: error: 'THIS_MODULE' =
undeclared here (not in a function)
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:229:20: error: expected =
declaration specifiers or '...' before string constant
> cc1: warnings being treated as errors
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:229:1: error: data definition =
has no type or storage class
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:229:1: error: type defaults to =
'int' in declaration of 'MODULE_DESCRIPTION'
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:229:20: error: function =
declaration isn't a prototype
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:230:16: error: expected =
declaration specifiers or '...' before string constant
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:230:1: error: data definition =
has no type or storage class
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:230:1: error: type defaults to =
'int' in declaration of 'MODULE_LICENSE'
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:230:16: error: function =
declaration isn't a prototype
> make[1]: *** [arch/powerpc/sysdev/fsl_85xx_l2ctlr.o] Error 1
>=20
> ...
>=20
>  CC      arch/powerpc/sysdev/fsl_85xx_cache_sram.o
> cc1: warnings being treated as errors
> arch/powerpc/sysdev/fsl_85xx_cache_sram.c:69:1: error: data definition =
has no type or storage class
> arch/powerpc/sysdev/fsl_85xx_cache_sram.c:69:1: error: type defaults =
to 'int' in declaration of 'EXPORT_SYMBOL'
> arch/powerpc/sysdev/fsl_85xx_cache_sram.c:69:1: error: parameter names =
(without types) in function declaration
> arch/powerpc/sysdev/fsl_85xx_cache_sram.c:80:1: error: data definition =
has no type or storage class
> arch/powerpc/sysdev/fsl_85xx_cache_sram.c:80:1: error: type defaults =
to 'int' in declaration of 'EXPORT_SYMBOL'
> arch/powerpc/sysdev/fsl_85xx_cache_sram.c:80:1: error: parameter names =
(without types) in function declaration
> make[1]: *** [arch/powerpc/sysdev/fsl_85xx_cache_sram.o] Error 1
>=20
> Signed-off-by: Claudiu Manoil <claudiu.manoil@freescale.com>
> ---
> Replaced <linux/module.h> with <linux/export.h> for =
fsl_85xx_cache_sram.c.
>=20
> arch/powerpc/sysdev/fsl_85xx_cache_sram.c |    1 +
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c     |    1 +
> 2 files changed, 2 insertions(+), 0 deletions(-)


applied

- k=
