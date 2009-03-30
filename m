Return-Path: <ypelletier@haivision.com>
Received: from mx11.exchange.telus.com (mx11.exchange.telus.com
	[216.123.224.145]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "mx11.exchange.telus.com", Issuer "RSA Data Security,
	Inc." (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 41D7FDDE28
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 02:57:34 +1100 (EST)
From: Yann Pelletier <ypelletier@haivision.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Date: Mon, 30 Mar 2009 09:57:27 -0600
Subject: Interrupts on GPIO
Message-ID: <9A8B45DD4DE17F4783430D784DA0B68811C41F9D9F@HEXMBVS12.hostedmsx.local>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,=20
I'd like to add supports for interrupts handling from GPIO controller.  Som=
e of these interrupts are from I2C devices and some others are from SPI dev=
ices.

What is the best approach to enable interrupts handling for those devices t=
hrough GPIO.

Note that I'm developing on a custom board based on mpc8313_rdb using linux=
 2.6.28.5


Also,=20

# cat /proc/interrupts
           CPU0      =20
 16:         60   IPIC   Level     serial
 17:          0   IPIC   Level     fpga
 18:          4   IPIC   Level     mpc83xx_spi
 21:          0   IPIC   Level     i2c-mpc
 22:          7   IPIC   Level     i2c-mpc

According to my platform device tree, serial irq should be on int9, SPI on =
int16 and i2c on int14,15.  This causes me some problems as I need int18 to=
 map to external IRQ2.

Thanks for support.

Yann
