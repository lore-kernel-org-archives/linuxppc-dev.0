Return-Path: <vijay_padiyar@hotmail.com>
Received: from hotmail.com (bay1-dav11.bay1.hotmail.com [65.54.244.115])
	by ozlabs.org (Postfix) with ESMTP id BC84067A65
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Mar 2005 23:57:38 +1100 (EST)
Message-ID: <BAY1-DAV11E7EFC29304B234EEB9A38B530@phx.gbl>
From: "Vijay Padiyar" <vijay_padiyar@hotmail.com>
To: "LinuxPPC Support" <linuxppc-embedded@ozlabs.org>
Date: Fri, 11 Mar 2005 18:28:04 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: query regarding I2C controller on MPC8260
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi there

I am using an MPC8260-based target board. My target is running U-Boot 1.1.2
as the bootloader and Linux-2.6.10 as the kernel with BusyBox-1.0. I wish to
use the I2C controller on the MPC8260 to access an external EEPROM connected
to it. I need to do this from *user space*.

>From what I understand, we can open the I2C device with the open command
from our application as follows:

ret = open ("/dev/i2c-0", O_RDWR);

After this, the device should be accessible using either standard I2C
functions or SMBus functions.

I read that if the I2C controller supports SMBus, it will be preferable to
access the device via the SMBus read/write functions, as they seem to be
more "efficient." What I want to know is, does the PowerPC I2C controller
support the SMBus protocol? I don't think it does, judging from the MPC8260
manual, but just want to be sure.

Also, do we need to create the /dev/i2c-0 device file manually or will it be
created on the fly?

Regards

Vijay Padiyar

http://www.vijaypadiyar.eu.tf
