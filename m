Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 79280DDFFD
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Feb 2008 03:52:40 +1100 (EST)
Message-ID: <47B471D2.3090906@anagramm.de>
Date: Thu, 14 Feb 2008 17:52:34 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: mahendra varman <mahendravarman15@gmail.com>
Subject: Re: reg Philips ISP 1562 usb controller support in linux2.6.23.11
References: <4ac2955e0802140528i69fece47xa6d751200c5616f9@mail.gmail.com>
In-Reply-To: <4ac2955e0802140528i69fece47xa6d751200c5616f9@mail.gmail.com>
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

mahendra varman schrieb:
> Hello all
> 
> If iam not using the open firmware architecture
> Then can u please help me what i need to enable in menuconfig for ISP 
> 1562 pci based usb controller ...

According to it's datasheet, The ISP1562 integrates normal OHCI / EHCI
compliant USB cores. My ISP1563 works fine with these CONFIGs enabled.

> Please do reply

Please don't push anybody.

Regards,

Clemens Koller
