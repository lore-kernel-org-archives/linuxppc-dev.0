Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 71BDD1A01E3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2016 20:28:23 +1100 (AEDT)
Date: Fri, 8 Jan 2016 10:28:18 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Anju T <anju@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 dsahern@gmail.com, acme@redhat.com, sukadev@linux.vnet.ibm.com,
 hemant@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V8 3/4] tools/perf: Map the ID values with register names
Message-ID: <20160108092818.GB18339@krava.brq.redhat.com>
References: <1452243751-382-1-git-send-email-anju@linux.vnet.ibm.com>
 <1452243751-382-4-git-send-email-anju@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1452243751-382-4-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 08, 2016 at 02:32:30PM +0530, Anju T wrote:

SNIP

> +#endif /* ARCH_PERF_REGS_H */
> diff --git a/tools/perf/config/Makefile b/tools/perf/config/Makefile
> index 38a0853..acf0302 100644
> --- a/tools/perf/config/Makefile
> +++ b/tools/perf/config/Makefile
> @@ -23,6 +23,11 @@ $(call detected_var,ARCH)
>  
>  NO_PERF_REGS := 1
>  
> +# Additional ARCH settings for ppc64
> +ifeq ($(ARCH),powerpc)
> +	NO_PERF_REGS := 0
> +endif

please use space for indent in makefiles.. the line might get
switched for rule one day and it's hard to find ;-)

thanks,
jirka
