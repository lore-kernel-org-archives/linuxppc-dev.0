Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 392E7DE1F9
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 04:45:50 +1100 (EST)
Message-Id: <24C74143-9A67-4B14-AE70-C02B7C892E47@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jochen Friedrich <jochen@scram.de>
In-Reply-To: <479A185D.6010406@scram.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCHv3 2.6.25] i2c: adds support for i2c bus on Freescale
	CPM1/CPM2 controllers
Date: Mon, 28 Jan 2008 11:01:46 -0600
References: <479A185D.6010406@scram.de>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, "Kernel,
	Linux" <linux-kernel@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>,
	Linux I2C <i2c@lm-sensors.org>, Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 25, 2008, at 11:11 AM, Jochen Friedrich wrote:

> Using the port of 2.4 code from Vitaly Bordug <vitb@kernel.crashing.org 
> >
> and the actual algorithm used by the i2c driver of the DBox code on
> cvs.tuxboc.org from Tmbinc, Gillem (htoa@gmx.net). Renamed i2c-rpx.c  
> and
> i2c-algo-8xx.c to i2c-cpm.c and converted the driver to an
> of_platform_driver.
>
> Signed-off-by: Jochen Friedrich <jochen@scram.de>
> ---
> arch/powerpc/boot/dts/mpc8272ads.dts         |   10 +
> arch/powerpc/boot/dts/mpc866ads.dts          |   10 +
> arch/powerpc/boot/dts/mpc885ads.dts          |   10 +
> arch/powerpc/platforms/8xx/mpc885ads_setup.c |    5 +
> drivers/i2c/busses/Kconfig                   |   10 +
> drivers/i2c/busses/Makefile                  |    1 +
> drivers/i2c/busses/i2c-cpm.c                 |  759 +++++++++++++++++ 
> +++++++++
> 7 files changed, 805 insertions(+), 0 deletions(-)

really should be split in two patches.  The drivers/i2c/* should go  
via the i2c maintainers.  the arch/powerpc via me or vitaly.

- k
