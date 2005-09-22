Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 7236D68321
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Sep 2005 02:05:11 +1000 (EST)
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B85946A@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B85946A@ismail.innsys.innovsys.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3D9AF92E-C441-466E-8708-C5C0051F3AC0@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 22 Sep 2005 11:05:24 -0500
To: "Rune Torgersen" <runet@innovsys.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: CPM2 early console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Rune's patch should be in 2.6.14-rc1 or greater.

- kumar

On Sep 22, 2005, at 11:02 AM, Rune Torgersen wrote:

> There is a bug in the SMC init code, wher the base address for the  
> SMC's
> is not reinitialized by the kernel, so if the SMC is not  
> initialized by
> the bootloader, it will not work.
>
> If that is the case, try this patch.
>
> -----Original Message-----
> From: Rune Torgersen
> Sent: Tuesday, August 23, 2005 15:19
> To: linuxppc-embedded@ozlabs.org
> Subject: [PATCH] ppc32: Fix baseaddress for SMC 1 and 2
>
> Base addess register for SMC 1 and 2 are never initialized.
> This means that they will not work unless a bootloader already
> configured them.
> The DPRAM already have space reserved, this patch just makes sure
> the base addess register is updated correctly on initialization.
>
> Signed-off-by: Rune Torgersen <runet@innovsys.com>
>
>
> <smc_baseparam.patch>
> <ATT296548.txt>
>
