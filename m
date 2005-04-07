Return-Path: <wojciech.kromer@dgt.com.pl>
Received: from dgt.com.pl (mail.dgt.com.pl [195.117.141.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E0FAC67A6F
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Apr 2005 17:51:44 +1000 (EST)
Message-ID: <4254E681.2090009@dgt.com.pl>
Date: Thu, 07 Apr 2005 09:51:29 +0200
From: Wojciech Kromer <wojciech.kromer@dgt.com.pl>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <4253CB3B.7040009@dgt.com.pl>	<977733d4c9325dbf4052cea66b10824c@aimsys.nl>	<4254D1D1.8090000@dgt.com.pl>
	<b401be5cfa8b051577b461a9ece7950d@aimsys.nl>
In-Reply-To: <b401be5cfa8b051577b461a9ece7950d@aimsys.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Subject: Re: USB on 8250 PCI
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dnia 2005-04-07 09:31, Użytkownik Jaap-Jan Boor napisał:

> What kernel version do you use?
> In a 2.4 series kernel, you might check m8260_pcibios_fixup()
> and probably set dev->irq ?
>
> I don't know yet if this is the same in 2.6. I recently saw a lot of 
> pci setup related changes in this mailing list.
>
> Jaap-Jan
>

i'm using 2.4.19 and 2.4.25 usb code
irqs, and io maps are set correctly

when trying to use ohci code there is one interrupt at startup:
<3>usb-ohci.c: OHCI Unrecoverable Error, controller usb-00:1e.0

anyone knows, what does it mean?
i've modified code to ignore it...
