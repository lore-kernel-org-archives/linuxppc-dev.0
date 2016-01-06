Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 371731A127F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jan 2016 04:44:59 +1100 (AEDT)
Date: Wed, 6 Jan 2016 18:44:53 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Anju T <anju@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, khandual@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 maddy@linux.vnet.ibm.com, dsahern@gmail.com, hemant@linux.vnet.ibm.com,
 naveen.n.rao@linux.vnet.ibm.com, acme@redhat.com,
 sukadev@linux.vnet.ibm.com
Subject: Re: [PATCH V7 3/4] tools/perf: Map the ID values with register names
Message-ID: <20160106174453.GB30771@krava.brq.redhat.com>
References: <1452073551-13737-1-git-send-email-anju@linux.vnet.ibm.com>
 <1452073551-13737-4-git-send-email-anju@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1452073551-13737-4-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 06, 2016 at 03:15:50PM +0530, Anju T wrote:

SNIP

> +	[PERF_REG_POWERPC_GPR28] = "gpr28",
> +	[PERF_REG_POWERPC_GPR29] = "gpr29",
> +	[PERF_REG_POWERPC_GPR30] = "gpr30",
> +	[PERF_REG_POWERPC_GPR31] = "gpr31",
> +	[PERF_REG_POWERPC_NIP] = "nip",
> +	[PERF_REG_POWERPC_MSR] = "msr",
> +	[PERF_REG_POWERPC_ORIG_R3] = "orig_r3",
> +	[PERF_REG_POWERPC_CTR] = "ctr",
> +	[PERF_REG_POWERPC_LNK] = "lnk",
> +	[PERF_REG_POWERPC_XER] = "xer",
> +	[PERF_REG_POWERPC_CCR] = "ccr",
> +	[PERF_REG_POWERPC_TRAP] = "trap",
> +	[PERF_REG_POWERPC_DAR] = "dar",
> +	[PERF_REG_POWERPC_DSISR] = "dsisr"
> +};
> +
> +static inline const char *perf_reg_name(int id)
> +{
> +

extra line ^^^ ;-)

> +	return reg_names[id];
> +}
> +#endif /* ARCH_PERF_REGS_H */
> diff --git a/tools/perf/config/Makefile b/tools/perf/config/Makefile

jirka
