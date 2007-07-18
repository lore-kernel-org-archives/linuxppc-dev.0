Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id E64A7DDE39
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 09:55:11 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 56/61] 82xx: Add pq2fads board support.
Date: Thu, 19 Jul 2007 01:54:54 +0200
References: <20070718013615.GB15238@ld0162-tx32.am.freescale.net>
In-Reply-To: <20070718013615.GB15238@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707190154.55368.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 18 July 2007, Scott Wood wrote:
> +static void __init pq2fads_setup_arch(void)
> +{
> +	struct device_node *np;
> +	struct resource r;
> +	u32 *bcsr;

bcsr should be __iomem, right? Did you run your code through sparse?

	Arnd <><
