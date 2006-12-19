Return-Path: <bwarren@qstreams.com>
Received: from smtp102.biz.mail.re2.yahoo.com (smtp102.biz.mail.re2.yahoo.com
	[68.142.229.216]) by ozlabs.org (Postfix) with SMTP id 7022EDDF23
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 09:26:28 +1100 (EST)
Subject: Re: [PATCH] powerpc: consolidate mpc83xx platform files
From: Ben Warren <bwarren@qstreams.com>
To: Kim Phillips <kim.phillips@freescale.com>
In-Reply-To: <20061219153040.22ae2d7c.kim.phillips@freescale.com>
References: <20061219153040.22ae2d7c.kim.phillips@freescale.com>
Content-Type: text/plain
Date: Tue, 19 Dec 2006 17:19:45 -0500
Message-Id: <1166566785.4793.38.camel@saruman.qstreams.net>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: bwarren@qstreams.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-12-19 at 15:30 -0600, Kim Phillips wrote:

> diff --git a/arch/powerpc/platforms/83xx/setup.c b/arch/powerpc/platforms/83xx/setup.c
> new file mode 100644
> index 0000000..6177581
> --- /dev/null
> +++ b/arch/powerpc/platforms/83xx/setup.c

<snip>
> +
> +static u8 __iomem *bcsr_regs = NULL;
> +
> +u8 *get_bcsr(void)
> +{
> +	return bcsr_regs;
> +}
> +

Sorry for rehashing this, but BCSR is a Freescale-only thing.  While I
realize it's something you guys put on all of your evaluation boards, I
doubt anybody else does.  It's a tiny amount of code, but does it belong
in the common file?

regards,
Ben
