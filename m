Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4FB98DDEAB
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Jul 2007 00:59:22 +1000 (EST)
Message-ID: <468A6441.105@freescale.com>
Date: Tue, 03 Jul 2007 09:59:13 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Ying Lin <ylin@airvana.com>
Subject: Re: Anyone using QE UART mode?
References: <8F798BFDA851B943B3A1B2510E9287850350A90D@airmail.wirelessworld.airvananet.com>
In-Reply-To: <8F798BFDA851B943B3A1B2510E9287850350A90D@airmail.wirelessworld.airvananet.com>
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

Ying Lin wrote:
> 
>> Which chip are you using?  There should be separate 16550 compatible
>> UART controller on MPC8360.  The driver is already there and working
>> pretty well.
> 
> We are using MPC8323E.  We have 2 working serial ports from the DUART
> controller, but we need more than 2.
> 
> We have about 4 weeks to make them working, any suggestion where to
> start?  We plan to start with CW QE Utility generated codes.

Have you tried using a PCI UART card?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
