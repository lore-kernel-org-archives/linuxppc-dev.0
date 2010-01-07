Return-Path: <khali@linux-fr.org>
Received: from bamako.nerim.net (bamako.nerim.net [62.4.17.28])
	by ozlabs.org (Postfix) with ESMTP id CAF56B6F04
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jan 2010 19:55:49 +1100 (EST)
Date: Thu, 7 Jan 2010 09:55:46 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: [lm-sensors] [RFC/PATCH 0/2] Updates to improve device tree
	support
Message-ID: <20100107095546.51d933af@hyperion.delvare>
In-Reply-To: <1262752236-1937-1-git-send-email-bgat@billgatliff.com>
References: <1262752236-1937-1-git-send-email-bgat@billgatliff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, lm-sensors@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Bill,

On Tue,  5 Jan 2010 22:30:33 -0600, Bill Gatliff wrote:
> This patch series updates the pca953x GPIO driver to take advantage
> of the new of_i2c_gpiochip_add() function, which registers i2c GPIO
> devices with the device tree API.  These changes allow i2c-based GPIO
> expanders to be properly referenced from the proper entries in a
> device tree.
> 
> The of_i2c_gpiochip_add() function has been posted for review on the
> linuxppc-dev mailing list.
> 
> Bill Gatliff (2):
>   Use struct of_i2c_gpio_chip instead of raw struct gpio_chip
>   Reorder initialization to better support device tree data
> 
>  drivers/gpio/pca953x.c |  168 +++++++++++++++++++++++++-----------------------
>  1 files changed, 88 insertions(+), 80 deletions(-)

This is totally off-topic for the lm-sensors mailing list, sorry.

-- 
Jean Delvare
