Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 37FBC679E7
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 06:06:50 +1000 (EST)
In-Reply-To: <451096FE.1000104@pobox.com>
References: <20060919145433.8fc7d478.sfr@canb.auug.org.au>
	<20060919184243.GL29167@austin.ibm.com>
	<45103C62.4080003@genesi-usa.com>
	<1158708269.6002.186.camel@localhost.localdomain>
	<488875E7-CCBC-47E1-A273-A2D037A997B2@kernel.crashing.org>
	<45109203.6060606@pobox.com>
	<1192ED41-329C-4CB0-AD87-B3BF62EC4337@kernel.crashing.org>
	<451096FE.1000104@pobox.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <82BFB659-DCB3-477C-B53D-4D8C55BAADB7@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Remove powerpc specific parts of 3c509 driver
Date: Wed, 20 Sep 2006 22:06:32 +0200
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	ppc-dev <linuxppc-dev@ozlabs.org>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> Sure, PCI busses are little-endian.  But is readX()/writeX() for  
>>>> PCI
>>>> only?
>>>
>>> Yes.
>>>
>>> For other buses, use foo_writel(), etc.
>> Can this please be documented then?  Never heard this before...
>
> You have come late to the party.

WHat do you mean here?  Could you please explain?

> This has been the case for many, many years.

No, it was never documented AFAICS.

> And there is no point in a massive rename to pci_writel(), either.

That would be really inconvenient, sure.  It's also inconvenient
that all the nice short names are PCI-only.


Segher
