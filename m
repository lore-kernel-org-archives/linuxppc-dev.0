Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EF469DDDEB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Feb 2007 01:33:51 +1100 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HJsXM-0000LB-GT
	for linuxppc-embedded@ozlabs.org; Wed, 21 Feb 2007 15:33:40 +0100
Received: from rusfw02.rohde-schwarz.com ([80.246.32.40])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 21 Feb 2007 15:33:40 +0100
Received: from euphoria by rusfw02.rohde-schwarz.com with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 21 Feb 2007 15:33:40 +0100
To: linuxppc-embedded@ozlabs.org
From: Florian Boelstler <euphoria@arcor.de>
Subject: Re: Undestanding ioread32() / readl() and friends
Date: Wed, 21 Feb 2007 15:33:32 +0100
Message-ID: <erhl7u$kc0$1@sea.gmane.org>
References: <erh4m0$n83$1@sea.gmane.org> <200702211056.28313.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <200702211056.28313.arnd@arndb.de>
Sender: news <news@sea.gmane.org>
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

Arnd Bergmann schrieb:
>> Is this a sort of general rule that ioread32() always returns 
>> little-endian values on all architectures?
> 
> the ioread family of functions is used for PCI devices, which
> are little-endian by definition.

OK, my knowledge about ioread32() was based on some explanations found 
in "Linux Device Drivers". IMHO they showed the ioread family of 
functions as a sort of general purpose functions for __iomem-alike 
resources.

Thanks, anyway.

   Florian
