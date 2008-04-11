Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 09CE3DE4EB
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Apr 2008 00:06:33 +1000 (EST)
Message-ID: <47FF705C.9040404@scram.de>
Date: Fri, 11 Apr 2008 16:06:20 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH0/7] OF support for i2c bus drivers
Content-Type: text/plain; charset=ISO-8859-15
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, "Kernel,
	Linux" <linux-kernel@vger.kernel.org>,
	Scott Wood <scottwood@freescale.com>, Jean Delvare <khali@linux-fr.org>,
	Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This series of patches implements the framework needed by of_platform_driver i2c bus drivers.
i2c-mpc is then converted to an of_platform_driver and i2c-cpm is added as new driver.

This is based on earlier work by Jon Smirl and Jean Delvare.

[PATCH1/7] i2c: Add support for device alias names
[PATCH2/7] i2c: Convert all new-style drivers to use module aliasing
[PATCH3/7] i2c: OF helpers for the i2c API
[PATCH4/7] i2c: Convert PowerPC MPC i2c to of_platform_driver from platform_driver
[PATCH5/7] i2c: Kill the old driver matching scheme
[PATCH6/7] i2c: adds support for i2c bus on Freescale CPM1/CPM2 controllers
[PATCH7/7] [POWERPC] Add i2c pins to dts and board setup

Thanks,
Jochen
