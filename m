Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2A941DDFFB
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 02:46:18 +1000 (EST)
Message-ID: <470BB055.6050602@freescale.com>
Date: Tue, 09 Oct 2007 11:46:13 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] qe: add function qe_clock_source
References: <1191945199488-git-send-email-timur@freescale.com>	<B8D11E08-7AC5-4B21-9C40-1068B29B058B@kernel.crashing.org>	<470BA5DF.5060206@freescale.com>	<2E830F97-ADAE-43CA-9BD3-BEBFEFBE1D5C@kernel.crashing.org>	<470BAAA2.30400@freescale.com>
	<8D4AA8EB-812F-4E58-A13C-CE3BA72037F3@kernel.crashing.org>
In-Reply-To: <8D4AA8EB-812F-4E58-A13C-CE3BA72037F3@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> Ok, I went and looked at how rx-clock & tx-clock are spec'd in  
> booting-without-of.txt
> 
> Why dont we fix this so we have a property that says "BRG" or "CLK"  
> and another that has ID = [1.16] for BRG and [1..24] for CLK.

Or we could keep it as it is, check the beginning of the string for 
"BRG" or "CLK", and binarize the number that follows.

Or we could just stop putting CLK information in the device tree. :-)

-Scott
