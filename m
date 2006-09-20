Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1A43967B6A
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 07:29:44 +1000 (EST)
Message-ID: <4511B2A0.2010607@pobox.com>
Date: Wed, 20 Sep 2006 17:29:04 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Remove powerpc specific parts of 3c509 driver
References: <20060919145433.8fc7d478.sfr@canb.auug.org.au>
	<20060919184243.GL29167@austin.ibm.com>
	<45103C62.4080003@genesi-usa.com>
	<1158708269.6002.186.camel@localhost.localdomain>
	<488875E7-CCBC-47E1-A273-A2D037A997B2@kernel.crashing.org>
	<45109203.6060606@pobox.com>
	<1192ED41-329C-4CB0-AD87-B3BF62EC4337@kernel.crashing.org>
	<451096FE.1000104@pobox.com>
	<82BFB659-DCB3-477C-B53D-4D8C55BAADB7@kernel.crashing.org>
In-Reply-To: <82BFB659-DCB3-477C-B53D-4D8C55BAADB7@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Segher Boessenkool wrote:
>>>>> Sure, PCI busses are little-endian.  But is readX()/writeX() for PCI
>>>>> only?
>>>>
>>>> Yes.
>>>>
>>>> For other buses, use foo_writel(), etc.
>>> Can this please be documented then?  Never heard this before...
>>
>> You have come late to the party.
> 
> WHat do you mean here?  Could you please explain?
> 
>> This has been the case for many, many years.
> 
> No, it was never documented AFAICS.

A de facto standard does not need to be documented, to be a de facto 
standard.

A lot of Linux "standards" are often based on emails from Linus buried 
halfway down a thread.  A decision gets made, and people follow.


>> And there is no point in a massive rename to pci_writel(), either.
> 
> That would be really inconvenient, sure.  It's also inconvenient
> that all the nice short names are PCI-only.

Only to you, a decided minority of developers.

	Jeff
