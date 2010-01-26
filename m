Return-Path: <david-b@pacbell.net>
Received: from smtp102.sbc.mail.gq1.yahoo.com (smtp102.sbc.mail.gq1.yahoo.com
	[67.195.15.61]) by ozlabs.org (Postfix) with SMTP id 5BC8F1007D2
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jan 2010 17:43:07 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 2/4] of/gpio: Add support for two-stage registration for
	the of_gpio_chips
Date: Mon, 25 Jan 2010 22:36:15 -0800
References: <20100125180957.GA5380@oksana.dev.rtsoft.ru>
	<20100125181103.GB13805@oksana.dev.rtsoft.ru>
In-Reply-To: <20100125181103.GB13805@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201001252236.16141.david-b@pacbell.net>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Bill Gatliff <bgat@billgatliff.com>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 25 January 2010, Anton Vorontsov wrote:
> With this patch there are two ways to register OF GPIO controllers:
> 
> 1. Allocating the of_gpio_chip structure and passing the
>    &of_gc->gc pointer to the gpiochip_add. (Can use container_of
>    to convert the gpio_chip to the of_gpio_chip.)
> 
> 2. Allocating and registering the gpio_chip structure separately
>    from the of_gpio_chip. (Since two allocations are separate,
>    container_of won't work.)
> 
> As time goes by we'll kill the first option.

Why have two options, instead of just the first/simpler one??
