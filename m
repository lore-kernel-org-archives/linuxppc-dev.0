Return-Path: <l.fu@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 2619DDDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Nov 2008 03:07:20 +1100 (EST)
Message-ID: <492EC197.1060503@pengutronix.de>
Date: Thu, 27 Nov 2008 16:49:43 +0100
From: Luotao Fu <l.fu@pengutronix.de>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: i2c-mpc clocking scheme
References: <492EB606.9020703@matrix-vision.de>
	<ed82fe3e0811270724t26d2a8e2v233143722eb8587f@mail.gmail.com>
In-Reply-To: <ed82fe3e0811270724t26d2a8e2v233143722eb8587f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andre Schwarz <andre.schwarz@matrix-vision.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> On Thu, Nov 27, 2008 at 9:00 AM, Andre Schwarz
> <andre.schwarz@matrix-vision.de> wrote:
>> All,
>>
>> is anybody working on some improvements regarding configurable I2C
>> frequency inside the i2c-mpc driver ?
>>
>> If not - would anybody be intersted in getting this done, i.e.
>> configurable via device tree ?
> 
> Maybe I'm missing something, but U-Boot configures the I2C bus speed.

i2c-mpc sets the bus clock in kernel with mpc_i2c_setclock. The bus
speed in kernel is indepedent from u-boot.

> It does this because the algorithm is specific to the SOC itself.  For
> example, the 8544 is different from the 8548.  It would be a mess to
> duplicate this code in the kernel.
> 

I did try to write some mechanismen to make the i2c bus speed
configurable for  mpc5200. I found it quite hard to find some algorithm
to calculate the right values in the Timing table of the I2C bus
controller. Anyhow I gave it up after starring at the datasheet for some
time. ;-) I can't speak for other platforms, which are supported by
i2c-mpc. Anyway, I do think it might be interesting to have configurable
i2c bus speed.

cheers
Luotao Fu
-- 
   Dipl.-Ing. Luotao Fu | Phone: +49-5121-206917-5004
Pengutronix - Linux Solutions for Science and Industry
Entwicklungszentrum Nord     http://www.pengutronix.de
