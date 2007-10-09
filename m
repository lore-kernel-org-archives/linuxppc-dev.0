Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 41F8ADDDFA
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 04:10:42 +1000 (EST)
In-Reply-To: <470BB0E6.4050801@freescale.com>
References: <1191945199488-git-send-email-timur@freescale.com>	<B8D11E08-7AC5-4B21-9C40-1068B29B058B@kernel.crashing.org>	<470BA5DF.5060206@freescale.com>	<2E830F97-ADAE-43CA-9BD3-BEBFEFBE1D5C@kernel.crashing.org>	<470BAAA2.30400@freescale.com>	<8D4AA8EB-812F-4E58-A13C-CE3BA72037F3@kernel.crashing.org>
	<470BAFA8.1060408@freescale.com> <470BB09D.7060304@freescale.com>
	<470BB0E6.4050801@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EF1344B5-5A53-4CC1-A51E-59EB9024B0C5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] qe: add function qe_clock_source
Date: Tue, 9 Oct 2007 13:10:53 -0500
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 9, 2007, at 11:48 AM, Timur Tabi wrote:

> Scott Wood wrote:
>
>> In the absence of a BRG, the driver should just not support  
>> changing the baud rate -- it shouldn't fail to function.
>
> Since I don't have hardware that can test external clocks, I can't  
> guarantee that any such code will work.
>
> I'm sure there are a dozen things I could do to improve the driver  
> as it stands, but I need to draw the line somewhere.

I guess my point is it appears the patch is related to how we  
represent the RX/TX clock information in the device tree.

I'm suggesting that we do something like:

rx-clock-type = "brg" or "clk"
rx-clock-id = 3

I don't see how this doesn't cover what you need in the device tree.

- k
