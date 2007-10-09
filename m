Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C1877DDF89
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 02:48:21 +1000 (EST)
Message-ID: <470BB0CF.7000007@freescale.com>
Date: Tue, 09 Oct 2007 11:48:15 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] qe: add function qe_clock_source
References: <1191945199488-git-send-email-timur@freescale.com>	<B8D11E08-7AC5-4B21-9C40-1068B29B058B@kernel.crashing.org>	<470BA5DF.5060206@freescale.com>	<2E830F97-ADAE-43CA-9BD3-BEBFEFBE1D5C@kernel.crashing.org>	<470BAAA2.30400@freescale.com>
	<8D4AA8EB-812F-4E58-A13C-CE3BA72037F3@kernel.crashing.org>
	<470BB055.6050602@freescale.com> <470BB087.7080607@freescale.com>
In-Reply-To: <470BB087.7080607@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> Scott Wood wrote:
> 
>> Or we could just stop putting CLK information in the device tree. :-)
> 
> If we had a BRG/CLK manager, we probably could do that.  But we don't 
> have something like that now.

I didn't say stop putting BRG information in there -- just CLKs, which 
are static setup that can be done in firmware or the board file.  This 
works fine on CPM1/2.

-Scott
