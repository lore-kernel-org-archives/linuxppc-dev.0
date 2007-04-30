Return-Path: <bounces@nabble.com>
Received: from talk.nabble.com (www.nabble.com [72.21.53.35])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6DDD1DDF60
	for <linuxppc-dev@ozlabs.org>; Tue,  1 May 2007 01:23:27 +1000 (EST)
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50) id 1HiXR0-0001VC-AE
	for linuxppc-dev@ozlabs.org; Mon, 30 Apr 2007 08:05:02 -0700
Message-ID: <10255005.post@talk.nabble.com>
Date: Mon, 30 Apr 2007 08:05:02 -0700 (PDT)
From: Mirek23 <miroslaw.dach@psi.ch>
To: linuxppc-dev@ozlabs.org
Subject: xilinx gpio in kernel 2.6
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi All,

           I am trying to build the kernel 2.6 for my ml403 board. I use the
kernel 2.6 by Grant.
The ethernet (Temac) and serial drivers work fine. It is however no support
for xilinx gpio in the kernel tree.

To satisfy that I have generated the xilinx_gpio driver by means of the EDK
8.2 .

I have tried to place the xilinx_gpio to the kernel 2.6 tree under
drivers/char/xilinx_gpio.

I have done the suitable configuration on the Makefile and Kconfig level.
When I build the kernel, the crosscompiler complaines about the
xgpio_ioctl.h which comes
from the adapter.c file.

It seems to be that xgpio_ioctl.h conatins the missing macros:
XGPIO_IN
XGPIO_OUT
XGPIO_TRISTATE
XGPIO_OPEN_DRAIN
.
.
.

Did sombody of you face the same problem? 
The second thing is that I did not find any documentation how to use GPIO on
the user level to access things like LEDS and Swiches on my xilinx board. Do
you have an idea how to do that (ie. which function calls to use).

Many thanks in advance for any hint.

Best Regards

Mirek
-- 
View this message in context: http://www.nabble.com/xilinx-gpio-in-kernel-2.6-tf3670144.html#a10255005
Sent from the linuxppc-dev mailing list archive at Nabble.com.
