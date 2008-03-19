Return-Path: <mhench@engagenet.com>
Received: from owa.engagenet.com (unknown [66.195.150.24])
	by ozlabs.org (Postfix) with ESMTP id 82DE4DDE9F
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 08:48:30 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: question about of_platform vs 'platform'
Date: Wed, 19 Mar 2008 16:49:18 -0500
Message-ID: <6629C06B144F5C4098DFF95C4FF9DAF702BA1D37@mailsrv.engagenet.com>
From: "Mike Hench" <mhench@engagenet.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sorry if this is a stupid question
I am new to PPC.
I am trying to make the SPI work on a MPC8313erdb board.
It isn't loading.
To that end, I added a printk to drivers/base/dd.c __driver_match
function

dmesg |grep -i spi

bus: 'of_platform': driver_probe_device: matching device e0007000.spi
with drive
r fsl-elbc
bus: 'platform': driver_probe_device: matching device fsl-usb2-udc.0
with driver
 mpc83xx_spi
bus: 'platform': driver_probe_device: matching device mpc83xx_wdt.0 with
driver
mpc83xx_spi
bus: 'platform': driver_probe_device: matching device fsl-i2c.0 with
driver mpc8
3xx_spi
bus: 'platform': driver_probe_device: matching device fsl-i2c.1 with
driver mpc8
3xx_spi
bus: 'platform': driver_probe_device: matching device Fixed MDIO bus.0
with driv
er mpc83xx_spi

it seems there is some sort of mismatch
how did the kernel decide that SPI was an 'of_platform' device.
The driver just uses 'platform' sorts of calls.
As opposed to the mpc52xx driver which uses of_platform.
The DTS file spi entry look similar to the i2c entries.
Those are treated as 'platform' devices.

A nudge/shove in the right direction would be appreciated.

Thanks.
Mike
