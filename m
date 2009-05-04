Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B9A0ADDDF6
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 06:58:11 +1000 (EST)
Date: Mon, 4 May 2009 13:53:27 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 9/9] spi_mpc8xxx: s/83xx/8xxx/g
Message-Id: <20090504135327.13cd42af.akpm@linux-foundation.org>
In-Reply-To: <20090430234833.GI7901@oksana.dev.rtsoft.ru>
References: <20090430234739.GA27709@oksana.dev.rtsoft.ru>
	<20090430234833.GI7901@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, dbrownell@users.sourceforge.net,
	linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 1 May 2009 03:48:33 +0400
Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> Since we renamed the file, we might want to rename the file
> internals too.
> 
> Though we don't bother with changing platform driver name and
> platform module alias. The stuff is legacy and hopefully we'll
> remove it soon.
> 

but but but

>
> -static struct of_platform_driver of_mpc83xx_spi_driver = {
> -	.name		= "mpc83xx_spi",
> -	.match_table	= of_mpc83xx_spi_match,
> -	.probe		= of_mpc83xx_spi_probe,
> -	.remove		= __devexit_p(of_mpc83xx_spi_remove),
> +static struct of_platform_driver of_mpc8xxx_spi_driver = {
> +	.name		= "mpc8xxx_spi",
> +	.match_table	= of_mpc8xxx_spi_match,
> +	.probe		= of_mpc8xxx_spi_probe,
> +	.remove		= __devexit_p(of_mpc8xxx_spi_remove),
>  };

It _did_ change the platform driver name, didn't it?


This patch series had quite a lot of conflicts with the already-pending

spi-move-common-spi_setup-functionality-into-core.patch
spi-move-more-spi_setup-functionality-into-core.patch

which I beleive I successfully fixed up.
