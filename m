Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A89CE1007D3
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Dec 2009 04:04:41 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nB1H4Mqh007745
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Dec 2009 10:04:32 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id nB1H99e6020736
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Dec 2009 11:09:09 -0600 (CST)
Message-ID: <4B154C82.5060100@freescale.com>
Date: Tue, 01 Dec 2009 11:04:02 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Mahajan Vivek-B08308 <B08308@freescale.com>
Subject: Re: [PATCH v3 3/3] powerpc/fsl: 85xx: add cache-sram support
References: <F2F605B667B24B489C904986E0D60A0801222492@zin33exm23.fsl.freescale.net>
In-Reply-To: <F2F605B667B24B489C904986E0D60A0801222492@zin33exm23.fsl.freescale.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
	Gala Kumar-B11780 <B11780@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mahajan Vivek-B08308 wrote:
>> From: Wood Scott-B07421 
>> Sent: Friday, November 20, 2009 11:09 PM
>>> Cache-sram does not have any device tree entry since it is not a 
>>> hardware as such. Putting it under chosen can be another option.
>>> I think, Scott (cc'ed) was of the opinion that since 32b 
>> base address 
>>> support is missing; so there is no point in moving this 
>> address to the 
>>> command line and .config should be okay for now for it.
>> I don't know what you mean by "32b base address support is 
>> missing".  I have no objection to putting it on the command line.
> 
> It was a typo, it should be missing 36b address support. Since the
> kernel 
> did not run under different environment (i.e 32b / 36b base address); so
> it 
> was decided that .config may be okay for this.

The kernel *will* run with a 36-bit address map even if some of our 
drivers don't support it right at the moment -- so we should be planning 
for it.

-Scott
