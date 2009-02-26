Return-Path: <henk.stegeman@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by ozlabs.org (Postfix) with ESMTP id ABF24DDDA1
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Feb 2009 23:13:36 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id d14so377411and.39
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Feb 2009 04:13:34 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 26 Feb 2009 13:13:34 +0100
Message-ID: <ae4f76fd0902260413t2220d311v3dbd4e0254a27c66@mail.gmail.com>
Subject: Two thoughts about SPI chip-selects in the DTS
From: Henk Stegeman <henk.stegeman@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

As far as I understand the DTS bindings now support an SPI master controller to
- use the chip-selects controlled directly by the SPI master controller hardware
or
- to use GPIO's trough gpiolib as chip selects
but not a combination of both, am I right?

Now every SPI driver needs to be adapted to provide support for using
gpios as chip-selects, Wouldn't it be possible to let the
divers/of/of_spi take care of all the work required to use gpios as
chip-selects?
