Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A2236B70A9
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Aug 2010 09:43:54 +1000 (EST)
Date: Tue, 3 Aug 2010 16:43:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Roy Zang <tie-fei.zang@freescale.com>
Subject: Re: [PATCH 1/3 v2] sdhci: Add auto CMD12 support for eSDHC driver
Message-Id: <20100803164346.69a63557.akpm@linux-foundation.org>
In-Reply-To: <1280805072-26112-1-git-send-email-tie-fei.zang@freescale.com>
References: <1280805072-26112-1-git-send-email-tie-fei.zang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-mmc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 3 Aug 2010 11:11:10 +0800
Roy Zang <tie-fei.zang@freescale.com> wrote:

> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -240,6 +240,8 @@ struct sdhci_host {
>  #define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN		(1<<25)
>  /* Controller cannot support End Attribute in NOP ADMA descriptor */
>  #define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<26)
> +/* Controller uses Auto CMD12 command to stop the transfer */
> +#define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12		(1<<27)

This becomes 1<<29 in my tree.

We're about to run out.  What happens then?
