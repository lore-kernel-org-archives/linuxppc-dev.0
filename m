Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0236.outbound.protection.outlook.com [207.46.163.236])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DBBD92C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 09:42:25 +1100 (EST)
Date: Wed, 19 Mar 2014 17:42:12 -0500
From: Scott Wood <scottwood@freescale.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Subject: Re: powerpc/config: Remove unnecssary CONFIG_FSL_IFC
Message-ID: <20140319224212.GA30134@home.buserror.net>
References: <1390652612-3553-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1390652612-3553-1-git-send-email-prabhakar@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jan 25, 2014 at 05:53:32PM +0530, Prabhakar Kushwaha wrote:
> CONFIG_FSL_IFC gets enabled by Kconfig dependancies.
> So remove unnecssary define from the defconfigs
> 
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> 
> ---
> arch/powerpc/configs/corenet64_smp_defconfig |    1 -
>  arch/powerpc/configs/mpc85xx_defconfig       |    1 -
>  arch/powerpc/configs/mpc85xx_smp_defconfig   |    1 -
>  3 files changed, 3 deletions(-)

I'll apply this, but FSL_IFC really should be made user-selectable
without needing to enable NAND support, since it also provides error
reporting for NOR and GPCM.

Also, when submitting patches like this, it's best to mention that it's
the output of running savedefconfig (and if that isn't how the patch was
generated, do it that way instead).

-Scott
