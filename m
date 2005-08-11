Return-Path: <clemens.koller@anagramm.de>
Received: from moutvdomng.kundenserver.de (moutvdom.kundenserver.de
	[212.227.126.249]) by ozlabs.org (Postfix) with ESMTP id C23D768086
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Aug 2005 21:14:30 +1000 (EST)
Message-ID: <42FB3048.7000202@anagramm.de>
Date: Thu, 11 Aug 2005 13:02:32 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: murahari@samsung.com
References: <0IL100L2IEO6NG@ms13.samsung.com>
In-Reply-To: <0IL100L2IEO6NG@ms13.samsung.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: copy_from_user problem
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Murahari!

> I am working on a character driver for reading and writing the registers to FPGA 
> in our system.

You didn't tell much about your system.
But checkout the examples in the book "Linux Device Drivers, 3rd Edition".
(http://lwn.net/images/pdf/LDD3/)
which is worth buying, too!

You might be missing some simple __user casts for your data
structures you want to copy...
And you might need to ioremap the memory area of your fpga or whatever
you need to access.

> epc  : 8011f774    Tainted: GF
                     ^^^^^^^^^^^
And you might end up with less support here if you use a tainted Kernel.

Greets,

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
