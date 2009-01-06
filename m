Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 759D047517
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 07:41:35 +1100 (EST)
Message-Id: <2B8AFE67-67BF-4926-B41B-79ACD72CA505@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20090106192747.GA3056@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH v2 4/4] powerpc/83xx: Add PCI-E support for all MPC83xx
	boards with PCI-E
Date: Tue, 6 Jan 2009 14:38:57 -0600
References: <20081229164040.GD8215@oksana.dev.rtsoft.ru>
	<C96CE59B-05FA-4728-930F-D4430EFB9B99@kernel.crashing.org>
	<20081230201916.GA20059@oksana.dev.rtsoft.ru>
	<1F7739C2-930B-49C1-B8FF-679AF1BBAEAE@kernel.crashing.org>
	<20081231171017.6FCF585AD247@gemini.denx.de>
	<B64DF110-E26A-4229-8384-E7933732BC01@kernel.crashing.org>
	<20090105174645.GA23766@ld0162-tx32.am.freescale.net>
	<20090105180122.GA12237@oksana.dev.rtsoft.ru>
	<c384c5ea0901061053r21fbc853y3b28ae3c8e3a0e6f@mail.gmail.com>
	<20090106192747.GA3056@oksana.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, Wolfgang Denk <wd@denx.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 6, 2009, at 1:27 PM, Anton Vorontsov wrote:

> On Tue, Jan 06, 2009 at 07:53:57PM +0100, Leon Woestenberg wrote:
>> Hello Anton,
>>
>> On Mon, Jan 5, 2009 at 7:01 PM, Anton Vorontsov
>> <avorontsov@ru.mvista.com> wrote:
>>> On Mon, Jan 05, 2009 at 11:46:45AM -0600, Scott Wood wrote:
>>>>
>>>> Why?  Unless the BSP u-boots do something insane, I think we  
>>>> should try
>>>> to have the upstream kernel boot on the u-boot that comes on the  
>>>> board
>>>> (it's not nice to require users to reflash unnecessarily).
>>>
>>> Just in case, the latest version of this patch set is compatible  
>>> with
>>> the FSL u-boots.
>>>
>>
>> Up to now, I was testing PCIe with this combo:
>> - U-Boot 1.3.0-rc2 (Nov 19 2007 - 16:37:36) MPC83XX, was on the board
>> - dtc 1.1.0
>> - Linux 2.6.24.3 w/ Freescale patches from http://www.bitshrine.org/gpp/
>>
>>
>> That u-boot (i.e. on the mpc8315e-rdb board) had PCIe initialization.
>>
>> Is u-boot PCIe initialization required for this kernel patch to work?
>
> Yup.

Really?  what for?

- k
