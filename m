Return-Path: <sfalco@harris.com>
Received: from mlbe2k2.cs.myharris.net (mlbe2k2.cs.myharris.net
	[137.237.90.89]) by ozlabs.org (Postfix) with ESMTP id C9A9FDE3B1
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 01:38:09 +1000 (EST)
Message-ID: <48D90D5D.5000105@harris.com>
Date: Tue, 23 Sep 2008 11:38:05 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: AMCC 440 SPI question
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The yosemite.dts has the following entry, which leads me to believe
that there is SPI support.  I'd like to do something similar for a
Sequoia board, but looking in Josh's "next" branch, I don't see any
driver that would recognize the spi-440ep string.  So my question is,
is there a SPI driver for the PPC440, that is .dts aware?

			spi@ef600900 {
				compatible = "amcc,spi-440ep";
				reg = <ef600900 6>;
				interrupts = <8 4>;
				interrupt-parent = <&UIC0>;
			};

Also, googling for a driver, I find the patch that introduced this
.dts file:

Patch: [PATCH 1/3][POWERPC] 4xx: Add AMCC 440EP Yosemite DTS
patchwork.ozlabs.org/linuxppc/patch?id=16992

However, when I click on the patchwork link, I get a 404 error.
Perhaps this just means the patch is old and has been removed
from patchwork.  But since it is a "1 of 3", I was hoping one of
the other parts would contain the actual spi-440ep driver code.

Hints greatly appreciated!

	Steve
