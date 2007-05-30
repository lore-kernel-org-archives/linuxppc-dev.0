Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 24799DDFB3
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 20:18:21 +1000 (EST)
In-Reply-To: <46B96294322F7D458F9648B60E15112C3075B9@zch01exm26.fsl.freescale.net>
References: <11798051102658-git-send-email-wei.zhang@freescale.com>
	<11798051101543-git-send-email-wei.zhang@freescale.com>
	<1179805110272-git-send-email-wei.zhang@freescale.com>
	<17B6534B-3C1C-433D-8875-1C2255E79D98@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C3075B9@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <dcf090010e24c9b93b7ed460010f2835@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/5] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
Date: Wed, 30 May 2007 12:18:02 +0200
To: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +			uli1575: uli1575@100 {
>>
>> is this the right address?
>
> '@100' of here, I make up  the address by get from bus 1, device 0,
> function 0.
> Such as below '@200' means bus 2, device 0, function0.

That is not how PCI unit addresses are encoded.  There are
two forms: bla@D and bla@D,F where D and F are device# and
function# respectively.  The bus# is implicit from the
parent node.

You have the "reg" property wrong, too (but differently).


Segher
