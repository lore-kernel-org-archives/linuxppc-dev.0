Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzV4t3yjnzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 15:25:50 +1000 (AEST)
Message-ID: <1462253150.4115.11.camel@neuling.org>
Subject: Re: [PATCH 7/9] powerpc/powernv: Add platform support for stop
 instruction
From: Michael Neuling <mikey@neuling.org>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Tue, 03 May 2016 15:25:50 +1000
In-Reply-To: <1461246599-6098-8-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1461246599-6098-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1461246599-6098-8-git-send-email-shreyas@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/a=
sm/cputable.h
> index df4fb5f..a4739a1 100644
> --- a/arch/powerpc/include/asm/cputable.h
> +++ b/arch/powerpc/include/asm/cputable.h
> @@ -205,6 +205,7 @@ enum {
> =C2=A0#define CPU_FTR_DABRX			LONG_ASM_CONST(0x0800000000000000)
> =C2=A0#define CPU_FTR_PMAO_BUG		LONG_ASM_CONST(0x1000000000000000)
> =C2=A0#define CPU_FTR_SUBCORE			LONG_ASM_CONST(0x2000000000000000)
> +#define CPU_FTR_STOP_INST		LONG_ASM_CONST(0x4000000000000000)

In general, we are putting all the POWER9 features under=C2=A0CPU_FTR_ARCH_=
300.
Is there a reason you need this separate bit?

CPU_FTR bits are fairly scarce these days.

Mikey
