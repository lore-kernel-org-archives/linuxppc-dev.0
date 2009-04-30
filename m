Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 12D3DDDF3D
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 21:28:06 +1000 (EST)
Message-Id: <124EE9CE-EFEA-4B33-ACEA-09D4050C2603@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <20090430065801.96E951222C@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 1/4] powerpc: Cleanup macros in ppc-opcode.h
Date: Thu, 30 Apr 2009 06:27:30 -0500
References: <20090430065801.96E951222C@localhost.localdomain>
Cc: Paul Mackerras <paulus@samba.org>, Milton Miller <miltonm@bga.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 30, 2009, at 1:58 AM, Michael Neuling wrote:

> Make macros more braces happy.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
>
> arch/powerpc/include/asm/ppc-opcode.h |    8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k

>
>
> Index: linux-2.6-ozlabs/arch/powerpc/include/asm/ppc-opcode.h
> ===================================================================
> --- linux-2.6-ozlabs.orig/arch/powerpc/include/asm/ppc-opcode.h
> +++ linux-2.6-ozlabs/arch/powerpc/include/asm/ppc-opcode.h
> @@ -47,10 +47,10 @@
> #define PPC_INST_WAIT			0x7c00007c
>
> /* macros to insert fields into opcodes */
> -#define __PPC_RA(a)	((a & 0x1f) << 16)
> -#define __PPC_RB(b)	((b & 0x1f) << 11)
> -#define __PPC_T_TLB(t)	((t & 0x3) << 21)
> -#define __PPC_WC(w)	((w & 0x3) << 21)
> +#define __PPC_RA(a)	(((a) & 0x1f) << 16)
> +#define __PPC_RB(b)	(((b) & 0x1f) << 11)
> +#define __PPC_T_TLB(t)	(((t) & 0x3) << 21)
> +#define __PPC_WC(w)	(((w) & 0x3) << 21)
>
> /* Deal with instructions that older assemblers aren't aware of */
> #define	PPC_DCBAL(a, b)		stringify_in_c(.long PPC_INST_DCBAL | \
