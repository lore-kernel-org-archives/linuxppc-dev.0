Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 12938DDDFD
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Sep 2007 23:42:29 +1000 (EST)
Message-ID: <46EBE143.60106@anagramm.de>
Date: Sat, 15 Sep 2007 15:42:27 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Nicholas Hickman <nhickman@dtechlabs.com>
Subject: Re: SPI INT line
References: <8140AAF341CC904BA92C3D6A5A1909782F0E9D@ditech-1.ditechllc.com>
In-Reply-To: <8140AAF341CC904BA92C3D6A5A1909782F0E9D@ditech-1.ditechllc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Nicholas Hickman schrieb:
> We are developing a system around the mpc8270.  On this system we are
> using an ISDN controller connected to the SPI interface of the 8270.
> For the INT line coming from the controller, should this be connected to
> one of the IRQ lines that we typically use for PCI bus, or should we
> connect it to one of the GPIO Group C pins?  Currently we have it to
> IRQ4, but I am worried that this is incorrect.

I would use an otherwise unused (even in reference 82xx platforms)
IRQ line and have a look into the kernel and see which
IRQs are free so minimize/eliminate extra patches.

Regards,
-- 
Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm-technology.com
Phone: +49-89-741518-50
Fax: +49-89-741518-19
