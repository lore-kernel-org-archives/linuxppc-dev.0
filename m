Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ABEB9DDFC6
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 05:15:32 +1000 (EST)
In-Reply-To: <470BC5CA.1010105@freescale.com>
References: <1191945199488-git-send-email-timur@freescale.com>	<B8D11E08-7AC5-4B21-9C40-1068B29B058B@kernel.crashing.org>	<470BA5DF.5060206@freescale.com>	<2E830F97-ADAE-43CA-9BD3-BEBFEFBE1D5C@kernel.crashing.org>	<470BAAA2.30400@freescale.com>	<8D4AA8EB-812F-4E58-A13C-CE3BA72037F3@kernel.crashing.org>
	<470BAFA8.1060408@freescale.com> <470BB09D.7060304@freescale.com>
	<470BB0E6.4050801@freescale.com>
	<EF1344B5-5A53-4CC1-A51E-59EB9024B0C5@kernel.crashing.org>
	<470BC484.3060702@freescale.com>
	<91CB543F-A0F2-42A4-AA5C-6F8FC99F9EC3@kernel.crashing.org>
	<470BC5CA.1010105@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B2FD32B4-241E-4FCF-A18D-1E619034EC3A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] qe: add function qe_clock_source
Date: Tue, 9 Oct 2007 14:15:45 -0500
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


On Oct 9, 2007, at 1:17 PM, Timur Tabi wrote:

> Kumar Gala wrote:
>
>> But that's a function of linux' use.  Remember decouple the device  
>> tree from how linux does things.
>
> Ok, I just understand what your point is.  I'm proposing that we  
> just put the name of the clock source in the device tree, and have  
> a function which converts that into an internal representation.   
> The clock is called "BRG3". It's not called BRG, #3 or something  
> like that.  Same thing with the CLK sources.

Ok.  I guess I'm not in favor of changing the device tree to address  
this issue.  I think it would be solved if "dtc" had #define support.

- k
