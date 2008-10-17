Return-Path: <sfalco@harris.com>
Received: from mlbe2k1.cs.myharris.net (mlbe2k1.cs.myharris.net
	[137.237.90.88]) by ozlabs.org (Postfix) with ESMTP id BE483DE0E0
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Oct 2008 03:07:23 +1100 (EST)
Message-ID: <48F8B833.7080807@harris.com>
Date: Fri, 17 Oct 2008 12:07:15 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 0/7 RFC] Handle I2C GPIO controllers with the OF (was:
	pca9539 I2C gpio expander)
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru>
In-Reply-To: <20081016171222.GA24812@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=windows-1251
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org, Jean Delvare <khali@linux-fr.org>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> Hi all,
> 
> Recently there was a question about I2C GPIO controllers and how should
> we handle them with the OpenFirmware and such.
> 
> Here is the attempt to "connect" I2C GPIO controllers to the
> "OpenFirmware" device tree, without writing an OF-specific bindings
> for each driver.
> 
> The salt is in these two patches:
> 
> [PATCH 3/7] of: fill the archdata for I2C devices
> ^ Here we're storing the device tree node into the I2C device.
> 
> [PATCH 5/7] of/gpio: implement of_dev_gpiochip_{add,remove} calls
> ^ And here we extracting the the stored node to put the registered
>   of_gpio_chip into that node.
> 
> 
> How does it look?

I've just tested this with a pca9539 chip attached to my Sequoia board,
and it works perfectly for me.  I don't have the mcu_mpc8349emitx.c file
in my tree, so I was not able to apply part 7 of 7, but the rest looks
fine.  Thanks for doing this.

Acked by: Steve Falco <sfalco@harris.com>
