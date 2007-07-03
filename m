Return-Path: <kari.davidsson@marel.is>
Received: from mail.marel.com (mail.marel.com [213.167.134.96])
	by ozlabs.org (Postfix) with ESMTP id EDAC5DDF32
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Jul 2007 01:08:53 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: OF devices and non OF devices
Date: Tue, 3 Jul 2007 14:54:20 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB020D3B9D@is-hdq-exchange.marel.net>
From: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kari.davidsson@marel.is>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I am attempting to get some non OF devices working for an mpc 5200 =
board, in particular=20
PCF8563 RTC.

This device has an non OF device interface which I believe is correct. =
After all it should work
on non OF platforms.

I have managed to get the board to run the i2c initialization (and =
probe) for the fsl-mpc i2c driver by
converting the fsl-mpc i2c driver to OF driver (I found some patch here =
that I based this work on).

Since the PCF8563 driver is not OF driver only its initaliziation code =
is run but the .probe function
of the driver is never run. Basically (as far as I can understand) the =
.probe is never run because the
driver is not an OF driver.

I could convert the PCF8563 driver to OF driver and make it work for our =
puposes but I feel this is
1) Wrong
2) therefore wasted work.

What seems to elude me is some glue that glues together the OF part of =
the driver space to the non OF part
of the driver space.

Any hints or pointers on where to find this glue?

Regards,
kd

P.S. Kernel is post 2.6.20.

--=20
K=E1ri Dav=ED=F0sson                   | kari.davidsson@marel.is
Hugb=FAna=F0arger=F0                   | www.marel.com
Tel: 563-8156 Fax: +354 563 8001
Iceland
