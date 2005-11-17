Return-Path: <clemens.koller@anagramm.de>
Received: from moutvdomng.kundenserver.de (moutvdom.kundenserver.de
	[212.227.126.249]) by ozlabs.org (Postfix) with ESMTP id 58B2B68748
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Nov 2005 22:02:00 +1100 (EST)
Message-ID: <437C632E.1080006@anagramm.de>
Date: Thu, 17 Nov 2005 12:02:06 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: zjznliang <zjznliang_popo@163.com>
References: <20051117075009.B2C4E6872B@ozlabs.org>
In-Reply-To: <20051117075009.B2C4E6872B@ozlabs.org>
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
> And there is nothing output ,I thought that it was serial port fault.
> I checked my Linux configuration ,but found nothing .

Check your kernel configuration.
Have you tried to turn on "early printk" support in your kernel config?
Linux might be booting already, but you just don't see it on your console.

Good luck,

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
