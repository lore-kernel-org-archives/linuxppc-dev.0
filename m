Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0111.outbound.protection.outlook.com [207.46.100.111])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A5F1B1A2EC4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 08:18:22 +1000 (AEST)
Message-ID: <1443133087.32298.62.camel@freescale.com>
Subject: Re: [PATCH] powerpc/e6500: add TMCFG0 register definition
From: Scott Wood <scottwood@freescale.com>
To: Laurentiu Tudor <b10716@freescale.com>
CC: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Laurentiu Tudor
 <Laurentiu.Tudor@freescale.com>, <kvm-ppc@vger.kernel.org>
Date: Thu, 24 Sep 2015 17:18:07 -0500
In-Reply-To: <5602BFEE.7060708@freescale.com>
References: <5602BFEE.7060708@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-09-23 at 18:06 +0300, Laurentiu Tudor wrote:
> The register is not currently used in the base kernel
> but will be in a forthcoming kvm patch.
> 
> Signed-off-by: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
> ---
>  arch/powerpc/include/asm/reg_booke.h | 6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Scott Wood <scottwood@freescale.com>

-Scott
