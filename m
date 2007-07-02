Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5D478DDF16
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 Jul 2007 01:40:45 +1000 (EST)
Message-ID: <46891C6B.3090507@freescale.com>
Date: Mon, 02 Jul 2007 10:40:27 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Ying Lin <ylin@airvana.com>
Subject: Re: Anyone using QE UART mode?
References: <8F798BFDA851B943B3A1B2510E9287850350A905@airmail.wirelessworld.airvananet.com>
In-Reply-To: <8F798BFDA851B943B3A1B2510E9287850350A905@airmail.wirelessworld.airvananet.com>
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
> How to enable TTY devices using QUICC Engine UCC UART Mode?
> 
> Are Linux kernel patches enough to enable them?  Or, additional 
> programming required?

I'm working on a device driver for QE UART mode, but it's not working yet.  The QE UART is 
like the CPM UART, but I'm having troubel getting it to work.

It is *not* trivial, or even easy, to enabled.  It's a full-blown UART driver that also 
deals with the complexity of the QE.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
