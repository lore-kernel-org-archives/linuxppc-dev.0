Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 748A9DE099
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 04:30:02 +1000 (EST)
Message-ID: <4863E021.6080408@freescale.com>
Date: Thu, 26 Jun 2008 13:29:53 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] powerpc: add of_find_next_property andof_get_aliased_index
References: <1214424332-18496-1-git-send-email-timur@freescale.com>	<c293d4d144094e5b0311b703e64893dc@kernel.crashing.org>	<4863B1C1.1060300@freescale.com>	<200806261751.05379.sr@denx.de>	<4863BBE2.2060107@freescale.com>
	<20080626142732.0ff6e64c@lappy.seanm.ca>
In-Reply-To: <20080626142732.0ff6e64c@lappy.seanm.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sean MacLennan wrote:
> On Thu, 26 Jun 2008 10:55:14 -0500
> "Timur Tabi" <timur@freescale.com> wrote:
> 
>> Well, there's a lot of disagreement on this subject.  Not only do we
>> not agree on a method of enumerating devices, a lot of people have a
>> problem with the concept of enumerating them in the first place!
> 
> An interesting point is that I enforced an index in the i2c-ibm_iic
> driver with no disagreement at all ;)

I added it to the fsl_soc as well without any fuss, but I may need to withdraw
it.  Technically, the I2C nodes in our device trees should not have a cell-index
property, because there are no shared registers.

-- 
Timur Tabi
Linux kernel developer at Freescale
