Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 34793DE10B
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 03:56:08 +1100 (EST)
Date: Wed, 12 Dec 2007 10:56:00 -0600
From: Scott Wood <scottwood@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH RFC 3/7] [POWERPC] CPM2: implement GPIO API
Message-ID: <20071212165600.GD4329@loki.buserror.net>
References: <20071210204705.GA31263@localhost.localdomain>
	<20071210204845.GC32278@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071210204845.GC32278@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 10, 2007 at 11:48:45PM +0300, Anton Vorontsov wrote:
> +EXPORT_SYMBOL_GPL(gpio_request);
> +EXPORT_SYMBOL_GPL(gpio_direction_input);
> +EXPORT_SYMBOL_GPL(gpio_direction_output);
> +EXPORT_SYMBOL_GPL(gpio_get_value);
> +EXPORT_SYMBOL_GPL(gpio_set_value);

These look like APIs, not internal functions.  Why the GPL DRM?

-Scott
