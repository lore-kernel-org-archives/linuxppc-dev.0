Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AC7C9DDED5
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 06:26:51 +1100 (EST)
Message-ID: <47448687.6010106@freescale.com>
Date: Wed, 21 Nov 2007 13:27:03 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/3] [POWERPC] Add docs for Freescale DMA & DMA channel
	device tree nodes
References: <Pine.LNX.4.64.0711202310280.24220@blarg.am.freescale.net>
	<Pine.LNX.4.64.0711202314030.24220@blarg.am.freescale.net>
	<474447EF.8080405@freescale.com>
	<E9CED991-4E10-44AE-A446-B6CB151FB9EE@kernel.crashing.org>
	<20071121173540.GC4413@loki.buserror.net>
	<8B189FFE-F45E-470C-87A0-E9FC61A1CF59@kernel.crashing.org>
In-Reply-To: <8B189FFE-F45E-470C-87A0-E9FC61A1CF59@kernel.crashing.org>
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
> On Nov 21, 2007, at 11:35 AM, Scott Wood wrote:
>> A cell-index property would be useful here for indexing into the summary
>> status register.
> 
> Divide by 0x80.

:-P

Using cell-index for things like this is reasonably common, and endorsed 
by current ePAPR drafts.

>>>>               dma@21300 {
>>>>                       #address-cells = <1>;
>>>>                       #size-cells = <1>;
>>>>                       compatible = "fsl,mpc8610-dma", "fsl,mpc8540-
>>>> dma";
>>>>       -->             device-id = <0>;
>>
>> I don't see any justification for having such a property in the parent 
>> node,
>> though.
> 
> huh?

Timur put device-id properties in both the parent and the channel nodes. 
  I was wondering why he did the former.

-Scott
