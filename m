Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5AD2DDDF96
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Feb 2008 02:21:41 +1100 (EST)
Message-ID: <47BD96F8.4090406@freescale.com>
Date: Thu, 21 Feb 2008 09:21:28 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Marco Stornelli <marco.stornelli@coritel.it>
Subject: Re: MPC8641D PCI-Express error
References: <47BC51B5.50204@coritel.it>	<BA5ADBDE-BDE5-4126-B012-DA6C5A8F8EF3@kernel.crashing.org>
	<47BD3001.2020004@coritel.it>
In-Reply-To: <47BD3001.2020004@coritel.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: LinuxPPC-Embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Marco Stornelli wrote:

> No, it didn't. I have the same problem even with the 2.6.18 plus the
> 2.6.24 PCI-Express code. I performed this action because I can't change
> kernel version but I can modify it.

Please try 2.6.24 (or even better, 2.6.25-rc2).  You may have done something 
wrong in back-porting the code to 2.6.18.  There's no reason why you can't at 
least try the latest version of the code for testing purposes, even if you can't 
use it in production.

-- 
Timur Tabi
Linux kernel developer at Freescale
