Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 16B91689E7
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jan 2006 09:59:20 +1100 (EST)
Date: Fri, 13 Jan 2006 14:58:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kumar Gala <galak@gate.crashing.org>
Subject: Re: [PATCH] powerpc: Add support for the MPC83xx watchdog
Message-Id: <20060113145804.7f6ee236.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0601131618020.26648-100000@gate.crashing.org>
References: <Pine.LNX.4.44.0601131618020.26648-100000@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: dave@cray.org, linux-kernel@vger.kernel.org,
	iinuxppc-embedded@gate.crashing.org, linuxppc-dev@ozlabs.org, wim@iguana.be
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala <galak@gate.crashing.org> wrote:
>
> +static struct platform_driver mpc83xx_wdt_driver = {
> +	.probe		= mpc83xx_wdt_probe,
> +	.remove		= __devexit_p(mpc83xx_wdt_remove),
> +	.driver		= {
> +		.owner	= THIS_MODULE,
> +		.name	= "mpc83xx_wdt",
> +	},
> +};

platform_driver.owner no longer needs to be initialised for some reason. 
I'll take that line out.
