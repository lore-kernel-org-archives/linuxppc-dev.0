Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9C62EB7BCC
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Oct 2009 01:47:41 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n95ElcOV013142
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Oct 2009 07:47:38 -0700 (MST)
Subject: Re: [PATCH 4/4] powerpc/fsl: 85xx: add cache-sram support
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <F2F605B667B24B489C904986E0D60A08FF6268@zin33exm23.fsl.freescale.net>
Date: Mon, 5 Oct 2009 09:47:35 -0500
Message-Id: <6D81C181-23BF-4FA7-B016-779919D61957@freescale.com>
References: <1253783426-11978-1-git-send-email-vivek.mahajan@freescale.com>
	<1253783426-11978-2-git-send-email-vivek.mahajan@freescale.com>
	<1253783426-11978-3-git-send-email-vivek.mahajan@freescale.com>
	<1253783426-11978-4-git-send-email-vivek.mahajan@freescale.com>
	<49156378-9156-4059-99C2-57E2815473BD@freescale.com>
	<F2F605B667B24B489C904986E0D60A08FF6268@zin33exm23.fsl.freescale.net>
To: Mahajan Vivek-B08308 <Vivek.Mahajan@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 5, 2009, at 2:15 AM, Mahajan Vivek-B08308 wrote:

>> From: Gala Kumar-B11780
>> Sent: Friday, September 25, 2009 12:08 AM
>>> +	mbar(1);
>>
>> why isn't eieio() sufficient here?
>
> When I initially added / tested cache SRAM for P2020RDB, its RM talked
> about using mbar() though mbar(1) is identical to eieio() opcode-wise.
> Also as cache-sram works only for 85xx derivatives, so I picked mbar()
> instead of eieio.

Let use eieio since there is no reason to special case the usage here  
for mbar(1)

- k
