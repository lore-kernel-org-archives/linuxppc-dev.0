Return-Path: <jjboor@aimsys.nl>
Received: from linserv001.aimsys.nl (a80-127-156-242.adsl.xs4all.nl
	[80.127.156.242])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E707B67A33
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Apr 2005 01:21:33 +1000 (EST)
In-Reply-To: <4253CB3B.7040009@dgt.com.pl>
References: <4253CB3B.7040009@dgt.com.pl>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <977733d4c9325dbf4052cea66b10824c@aimsys.nl>
From: Jaap-Jan Boor <jjboor@aimsys.nl>
Date: Wed, 6 Apr 2005 14:12:02 +0200
To: Wojciech Kromer <wojciech.kromer@dgt.com.pl>
Cc: linuxppc-embedded@ozlabs.org
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


On 6-apr-05, at 13:42, Wojciech Kromer wrote:

> anyone have tested USB host controller on pci with mpc8250
> i have NEC PD720101  ohci/ehci device

yes, mpc8270 with Philips 1561
(I found the CPM USB host controller with 1 ms SOF
under software control too risky)

the 1561 is OHCI/EHCI compliant, the standard linux drivers
can be used

>
> i have no response from usb devices
> any hints?
>
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
