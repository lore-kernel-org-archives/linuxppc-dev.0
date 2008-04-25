Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id A3170DE39F
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 23:07:38 +1000 (EST)
Date: Fri, 25 Apr 2008 17:07:37 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] add gpiolib support for mpc5200
Message-ID: <20080425130737.GA3430@polina.dev.rtsoft.ru>
References: <20080424153659.GJ6692@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20080424153659.GJ6692@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 24, 2008 at 05:36:59PM +0200, Sascha Hauer wrote:

> +#include <linux/of.h>
> +#include <linux/kernel.h>
> +#include <linux/of_gpio.h>
> +#include <linux/io.h>
> +#include <asm/of_platform.h>
> +#include <asm/prom.h>
> +#include <asm/gpio.h>

In the latest kernels the preferred way is to include <linux/gpio.h>,
the patch introducing it was merged just recently, so few people know
about it yet.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
