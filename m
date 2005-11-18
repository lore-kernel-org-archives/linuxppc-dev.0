Return-Path: <clemens.koller@anagramm.de>
Received: from moutvdomng.kundenserver.de (moutvdom.kundenserver.de
	[212.227.126.249]) by ozlabs.org (Postfix) with ESMTP id CFF0D68734
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Nov 2005 05:44:21 +1100 (EST)
Message-ID: <437E20FF.8060709@anagramm.de>
Date: Fri, 18 Nov 2005 19:44:15 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: zjznliang <zjznliang_popo@163.com>
References: <20051118024803.E2988687A1@ozlabs.org>
In-Reply-To: <20051118024803.E2988687A1@ozlabs.org>
Content-Type: text/plain; charset=GB2312
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Help ! 2.6.14 kernel can't bring up
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, zjznliang!

zjznliang wrote:
> Hi linuxppc-embedded£¡
> 
> 	Hi , How to config the "early printk" in 2.6.14 linux configration???

Well... check the .config or the kernel sources for
CONFIG_EARLY_PRINTK
or
CONFIG_WANT_EARLY_SERIAL

Have a look at the bootup code of your board, where it's used.
I would call the printk as soon as the serial ports are initialized.
If that's too late, try to toggle some pin as early as possible.
If that doesn't work, and if you have no more ideas of what to do,
you might think about getting some hardware debugging tools.

Best greets,
-- 
Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19
