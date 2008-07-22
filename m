Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3A97EDE072
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 00:09:38 +1000 (EST)
Date: Tue, 22 Jul 2008 14:52:15 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: latest tree build failure -- cpm uart & gpio
Message-ID: <20080722145215.2cf6fdd9@lxorguk.ukuu.org.uk>
In-Reply-To: <FBE46DB6-A457-4AD8-9D6E-9D639AD04325@freescale.com>
References: <FBE46DB6-A457-4AD8-9D6E-9D639AD04325@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 22 Jul 2008 08:54:16 -0500
Kumar Gala <kumar.gala@freescale.com> wrote:

> can someone look at the following compile failure in linus's tree.   
> I'm guessing part of this has to do with Alan's tty changes (and might  
> already be addressed?).
> 
> include/asm-generic/gpio.h:131: error: implicit declaration of  
> function 'gpio_get_value'
> include/asm-generic/gpio.h:137: error: implicit declaration of  
> function 'gpio_set_value'

These are not

> make[4]: *** [drivers/net/fs_enet/fs_enet-main.o] Error 1
> drivers/serial/cpm_uart/cpm_uart_core.c:212: error: 'struct uart_info'  
> has no member named 'tty'

That one is and hasn't been addressed so I wil do it right now.
