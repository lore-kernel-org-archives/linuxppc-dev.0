Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrGHF371WzDqcm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 21:09:45 +1000 (AEST)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 21 Apr 2016 21:09:44 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 0B74C2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 21:09:40 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3LB9QYu64815252
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 21:09:40 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3LB91Na017597
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 21:09:02 +1000
Date: Thu, 21 Apr 2016 16:37:36 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Anju T <anju@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, mpe@ellerman.id.au, maddy@linux.vnet.ibm.com,
 jolsa@redhat.com, dsahern@gmail.com, acme@redhat.com,
 sukadev@linux.vnet.ibm.com, hemant@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V11 1/4] perf/powerpc: assign an id to each powerpc
 register
Message-ID: <20160421110736.GC28637@naverao1-tp.ibm.com>
References: <1455944568-7231-1-git-send-email-anju@linux.vnet.ibm.com>
 <1455944568-7231-2-git-send-email-anju@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455944568-7231-2-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/02/20 10:32AM, Anju T wrote:
> The enum definition assigns an 'id' to each register in "struct pt_regs"
> of arch/powerpc. The order of these values in the enum definition are
> based on the corresponding macros in arch/powerpc/include/uapi/asm/ptrace.h.
> 
> Signed-off-by: Anju T <anju@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/uapi/asm/perf_regs.h | 50 +++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 arch/powerpc/include/uapi/asm/perf_regs.h

This patch doesn't enable anything and doesn't look to be useful by 
itself. Please merge this with your second patch.

- Naveen

> 
> diff --git a/arch/powerpc/include/uapi/asm/perf_regs.h b/arch/powerpc/include/uapi/asm/perf_regs.h
> new file mode 100644
> index 0000000..62b8a5e
> --- /dev/null
> +++ b/arch/powerpc/include/uapi/asm/perf_regs.h
> @@ -0,0 +1,50 @@
> +#ifndef _ASM_POWERPC_PERF_REGS_H
> +#define _ASM_POWERPC_PERF_REGS_H
> +
> +enum perf_event_powerpc_regs {
> +	PERF_REG_POWERPC_R0,
> +	PERF_REG_POWERPC_R1,
> +	PERF_REG_POWERPC_R2,
> +	PERF_REG_POWERPC_R3,
> +	PERF_REG_POWERPC_R4,
> +	PERF_REG_POWERPC_R5,
> +	PERF_REG_POWERPC_R6,
> +	PERF_REG_POWERPC_R7,
> +	PERF_REG_POWERPC_R8,
> +	PERF_REG_POWERPC_R9,
> +	PERF_REG_POWERPC_R10,
> +	PERF_REG_POWERPC_R11,
> +	PERF_REG_POWERPC_R12,
> +	PERF_REG_POWERPC_R13,
> +	PERF_REG_POWERPC_R14,
> +	PERF_REG_POWERPC_R15,
> +	PERF_REG_POWERPC_R16,
> +	PERF_REG_POWERPC_R17,
> +	PERF_REG_POWERPC_R18,
> +	PERF_REG_POWERPC_R19,
> +	PERF_REG_POWERPC_R20,
> +	PERF_REG_POWERPC_R21,
> +	PERF_REG_POWERPC_R22,
> +	PERF_REG_POWERPC_R23,
> +	PERF_REG_POWERPC_R24,
> +	PERF_REG_POWERPC_R25,
> +	PERF_REG_POWERPC_R26,
> +	PERF_REG_POWERPC_R27,
> +	PERF_REG_POWERPC_R28,
> +	PERF_REG_POWERPC_R29,
> +	PERF_REG_POWERPC_R30,
> +	PERF_REG_POWERPC_R31,
> +	PERF_REG_POWERPC_NIP,
> +	PERF_REG_POWERPC_MSR,
> +	PERF_REG_POWERPC_ORIG_R3,
> +	PERF_REG_POWERPC_CTR,
> +	PERF_REG_POWERPC_LNK,
> +	PERF_REG_POWERPC_XER,
> +	PERF_REG_POWERPC_CCR,
> +	PERF_REG_POWERPC_SOFTE,
> +	PERF_REG_POWERPC_TRAP,
> +	PERF_REG_POWERPC_DAR,
> +	PERF_REG_POWERPC_DSISR,
> +	PERF_REG_POWERPC_MAX,
> +};
> +#endif /* _ASM_POWERPC_PERF_REGS_H */
> -- 
> 2.1.0
> 
