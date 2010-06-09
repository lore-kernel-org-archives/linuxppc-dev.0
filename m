Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8F89E100804
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Jun 2010 20:32:50 +1000 (EST)
Date: Wed, 9 Jun 2010 11:25:44 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: Re: [PATCH 2/2] sound/soc: mpc5200_psc_ac97: Use gpio pins for
	cold reset.
Message-ID: <20100609102543.GB5618@opensource.wolfsonmicro.com>
References: <1276015562-28928-1-git-send-email-emillbrandt@dekaresearch.com>
	<1276015562-28928-2-git-send-email-emillbrandt@dekaresearch.com>
	<1276015562-28928-3-git-send-email-emillbrandt@dekaresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1276015562-28928-3-git-send-email-emillbrandt@dekaresearch.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 08, 2010 at 12:46:02PM -0400, Eric Millbrandt wrote:

> +       switch (psc_dma->id) {
> +       case 0:
> +               gpio_mux = MPC52xx_GPIO_PSC1_MASK; break;
> +       case 1:
> +               gpio_mux = MPC52xx_GPIO_PSC2_MASK; break;

Please don't place the break on the same line as the statement, it's
not good for legibility.

> +       dev_err(psc_dma->dev, "cold reset\n");

You shouldn't be logging this as an error, doing a cold reset is
perfectly normal.
