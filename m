Return-Path: <bhutchings@solarflare.com>
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "WEBMAIL.SOLARFLARE.COM",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 757552C0246
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Nov 2013 05:16:52 +1100 (EST)
Message-ID: <1383675404.2868.8.camel@bwh-desktop.uk.level5networks.com>
Subject: Re: [PATCH 3/7] IBM Akebono: Add support for a new PHY to the IBM
 emac driver
From: Ben Hutchings <bhutchings@solarflare.com>
To: Alistair Popple <alistair@popple.id.au>
Date: Tue, 5 Nov 2013 18:16:44 +0000
In-Reply-To: <1383629471-16979-3-git-send-email-alistair@popple.id.au>
References: <1383629471-16979-1-git-send-email-alistair@popple.id.au>
 <1383629471-16979-3-git-send-email-alistair@popple.id.au>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-11-05 at 16:31 +1100, Alistair Popple wrote:
[...]
> --- a/drivers/net/ethernet/ibm/emac/Kconfig
> +++ b/drivers/net/ethernet/ibm/emac/Kconfig
> @@ -55,6 +55,10 @@ config IBM_EMAC_RGMII
>  	bool
>  	default n
>  
> +config IBM_EMAC_RGMII_WOL
> +	bool
> +	default n
> +
[...]

So no-one can even build-test this at present!

Ben.

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
