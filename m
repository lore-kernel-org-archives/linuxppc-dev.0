Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0204.outbound.protection.outlook.com [207.46.163.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CA6ED1400BE
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Apr 2014 08:08:06 +1000 (EST)
Message-ID: <1397858858.1694.133.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc/fsl: Updated device trees for platforms with
 corenet version 2
From: Scott Wood <scottwood@freescale.com>
To: Diana Craciun <diana.craciun@freescale.com>
Date: Fri, 18 Apr 2014 17:07:38 -0500
In-Reply-To: <1397834470-12844-1-git-send-email-diana.craciun@freescale.com>
References: <1397834470-12844-1-git-send-email-diana.craciun@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-04-18 at 18:21 +0300, Diana Craciun wrote:
> From: Diana Craciun <Diana.Craciun@freescale.com>
> 
> Updated the device trees according to the corenet-cf
> binding definition.
> 
> Signed-off-by: Diana Craciun <Diana.Craciun@freescale.com>
> ---
>  arch/powerpc/boot/dts/b4860emu.dts          | 2 +-
>  arch/powerpc/boot/dts/fsl/b4420si-post.dtsi | 4 ----
>  arch/powerpc/boot/dts/fsl/b4860si-post.dtsi | 4 ----
>  arch/powerpc/boot/dts/fsl/b4si-post.dtsi    | 2 +-
>  arch/powerpc/boot/dts/fsl/t4240si-post.dtsi | 2 +-
>  arch/powerpc/boot/dts/t4240emu.dts          | 2 +-
>  6 files changed, 4 insertions(+), 12 deletions(-)

Could you update the corenet version 1 trees as well?

-Scott
