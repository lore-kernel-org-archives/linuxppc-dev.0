Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2DCE9DDD0B
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Feb 2009 03:53:59 +1100 (EST)
Message-ID: <4995A591.1040105@freescale.com>
Date: Fri, 13 Feb 2009 10:53:37 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jean-Michel Hautbois <jhautbois@gmail.com>
Subject: Re: [MPC8272ADS]Problem adding flash partitions inside the device tree
References: <8cad0aa0902120123p27cfe32fg6bf08d458178c937@mail.gmail.com>	
	<49940265.1020700@vastech.co.za>	
	<8cad0aa0902120310g44a3bf3cla4ffa94ea9bf5dc6@mail.gmail.com>	
	<20090212133037.GA3651@yookeroo.seuss>	
	<8cad0aa0902120536p3303322cvf9a7307391d195b9@mail.gmail.com>	
	<49942D68.7080706@vastech.co.za>	
	<8cad0aa0902120626v733011a5u669fc30096565d86@mail.gmail.com>	
	<20090212222403.GA10344@ld0162-tx32.am.freescale.net>
	<8cad0aa0902130125h496f712bh809cfb1d45d6ad17@mail.gmail.com>
In-Reply-To: <8cad0aa0902130125h496f712bh809cfb1d45d6ad17@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jean-Michel Hautbois wrote:
> 2009/2/12 Scott Wood <scottwood@freescale.com>:
>> On Thu, Feb 12, 2009 at 03:26:58PM +0100, Jean-Michel Hautbois wrote:
>>> I think that the problem is in the reg part, but I can't understand why.
>>> Isn't it the RAM mpping of my MTD that is the first address ?
>> No, it's the offset into the chipselect.
>>
>> -Scott
>>
> 
> OK.
> What means the word #adress-cells BTW ?

It's the number of cells that make up an address.  1 cell for 32-bit 
addresses, 2 for 64-bit.

> When should I have 1, 2 or anything else ?

1 cell is sufficient in this case.

-Scott
