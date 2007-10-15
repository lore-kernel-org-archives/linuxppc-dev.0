Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EF16FDDDFF
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 05:10:21 +1000 (EST)
Message-ID: <4713BB1B.5070102@freescale.com>
Date: Mon, 15 Oct 2007 14:10:19 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/2] [RFC][POWERPC] MPC8568E-MDS: create localbus node
References: <20071015153525.GA28761@localhost.localdomain>
	<47138A54.8030307@ru.mvista.com>
	<20071015155730.GA30008@localhost.localdomain>
	<20071015184743.GA4474@loki.buserror.net>
	<3387D0D7-EBB8-4346-853D-75850159BCE4@kernel.crashing.org>
In-Reply-To: <3387D0D7-EBB8-4346-853D-75850159BCE4@kernel.crashing.org>
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

Kumar Gala wrote:
> 
> On Oct 15, 2007, at 1:47 PM, Scott Wood wrote:
> 
>> On Mon, Oct 15, 2007 at 07:57:30PM +0400, Anton Vorontsov wrote:
>>> On Mon, Oct 15, 2007 at 07:42:12PM +0400, Sergei Shtylyov wrote:
>>>>    Is the entity described as "localbus" indeed so *board* specific?
>>>
>>> That's what booting-without-of.txt gives as an example.
>>
>> The board should have been left out of that.  Your compatible should be
>> something like "fsl,mpc8568-localbus", possibly with some canonical 
>> mpc85xx
>> chip as well, chosen to represent 85xx localbus in general.
> 
> Lets be careful, there are at least two forms of localbus on 85xx.

Do you mean LAWBAR v. BRn/ORn (the manuals refer to the latter as 
"localbus", so I'd be inclined to stick with that name, and call the 
former mpc8568-lawbar or something), or some 85xx being different than 
others?

-Scott
