Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 92963DDE1C
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 23:54:34 +1000 (EST)
Message-Id: <FBE46DB6-A457-4AD8-9D6E-9D639AD04325@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: latest tree build failure -- cpm uart & gpio
Date: Tue, 22 Jul 2008 08:54:16 -0500
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

can someone look at the following compile failure in linus's tree.   
I'm guessing part of this has to do with Alan's tty changes (and might  
already be addressed?).

include/asm-generic/gpio.h:131: error: implicit declaration of  
function 'gpio_get_value'
include/asm-generic/gpio.h:137: error: implicit declaration of  
function 'gpio_set_value'
make[4]: *** [drivers/net/fs_enet/fs_enet-main.o] Error 1
drivers/serial/cpm_uart/cpm_uart_core.c:212: error: 'struct uart_info'  
has no member named 'tty'
make[4]: *** [drivers/serial/cpm_uart/cpm_uart_core.o] Error 1
make[3]: *** [drivers/serial/cpm_uart] Error 2
make[3]: *** [drivers/net/fs_enet] Error 2
make[2]: *** [drivers/net] Error 2
make[2]: *** [drivers/serial] Error 2
make[1]: *** [drivers] Error 2
make: *** [sub-make] Error 2

- k
