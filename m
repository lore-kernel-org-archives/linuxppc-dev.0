Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6F41D67C7C
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Dec 2006 01:46:38 +1100 (EST)
In-Reply-To: <1166058412.6838.30.camel@concordia.ozlabs.ibm.com>
References: <1166006370.90082.476088563252.qpush@cradle>
	<20061213104007.4B8F967DA9@ozlabs.org>
	<20061213122353.7498a25e@pb15>
	<1166052344.11914.233.camel@localhost.localdomain>
	<20061213180921.487b1cea@pb15>
	<1166056373.11914.246.camel@localhost.localdomain>
	<1166057940.6838.25.camel@concordia.ozlabs.ibm.com>
	<1166058148.11914.255.camel@localhost.localdomain>
	<1166058412.6838.30.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C53BBACC-211E-4B01-9153-75634372B835@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 6/9] MPIC MSI allocator
Date: Thu, 14 Dec 2006 15:46:26 +0100
To: michael@ellerman.id.au
Cc: Olof Johansson <olof@lixom.net>, linux-pci@atrey.karlin.mff.cuni.cz,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> if get_property("msi_available")
>>> 	mpic_msi_reserve_dt_irqs()
>>
>> available-msi is a better name now that I think of it, or better  
>> even:
>> "msi-ranges"
>
> "msi-ranges" is ambiguous, are the ranges available or reserved?
>
> How about "msi-available-ranges" :D

The property describes vectors that are not (yet) in use by
the hardware; so let's do "available-vectors"?


Segher
