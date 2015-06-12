Return-Path: <pebolle@tiscali.nl>
Received: from lb2-smtp-cloud2.xs4all.net (lb2-smtp-cloud2.xs4all.net
 [194.109.24.25])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6E6D01A0601
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2015 18:57:49 +1000 (AEST)
Message-ID: <1434099462.2271.149.camel@x220>
Subject: Re: [PATCH v2] powerpc/rcpm: add RCPM driver
From: Paul Bolle <pebolle@tiscali.nl>
To: Yuantian.Tang@freescale.com
Cc: b07421@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Chenhui Zhao
 <chenhui.zhao@freescale.com>
Date: Fri, 12 Jun 2015 10:57:42 +0200
In-Reply-To: <1434004357-2294-1-git-send-email-Yuantian.Tang@freescale.com>
References: <1434004357-2294-1-git-send-email-Yuantian.Tang@freescale.com>
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

Just a nit.

On Thu, 2015-06-11 at 14:32 +0800, Yuantian.Tang@freescale.com wrote:
> --- /dev/null
> +++ b/arch/powerpc/sysdev/fsl_rcpm.c

> +int fsl_rcpm_init(void)

This is used only through early_initcall(). I took the cargo cult
approach of looking at the other uses of early_initcall() in
arch/powerpc/. That approach tells me this function could be static and
marked as __init. Would that work here too?

> +{
> +	[...]
> +}
> +
> +/* need to call this before SMP init */
> +early_initcall(fsl_rcpm_init);

Thanks,

Paul Bolle
