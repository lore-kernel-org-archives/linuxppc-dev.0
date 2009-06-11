Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AB15AB7155
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 00:50:13 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 04C1CDDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 00:50:12 +1000 (EST)
Message-Id: <344E0328-E45B-42B7-89D3-C5E1D83ADA29@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1244730787.4599.94.camel@concordia>
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: "test" branch updates
Date: Thu, 11 Jun 2009 09:49:59 -0500
References: <1242631175.18075.54.camel@pasglop>
	<1244730787.4599.94.camel@concordia>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 11, 2009, at 9:33 AM, Michael Ellerman wrote:

> On Mon, 2009-05-18 at 17:19 +1000, Benjamin Herrenschmidt wrote:
>> Just a quick note before I leave the office...
>>
>> I've just pushed out a bunch of stuff to my "test" branch. There's a
>> couple of known breakage (iseries and 8xx) which will have to be =20
>> sorted
>> out before that stuff goes into "next". hopefully in a couple of =20
>> days.
>>
>> Still... feel free to take a peek, test, etc...
>
> The swiotlb stuff doesn't build:
>
> arch/powerpc/kernel/dma-swiotlb.c
>   In function =91swiotlb_bus_to_virt=92:
>  29: warning: passing argument 1 of =91swiotlb_bus_to_phys=92 makes =20=

> integer from pointer without a cast
>  29: error: too many arguments to function =91swiotlb_bus_to_phys=92
>   At top level:
>  42: error: conflicting types for =91swiotlb_bus_to_phys=92
>
>
> There's changes in linux-next that make it work, which look like =20
> they're
> going via Ingo?

I think those changes are now in Linus's tree.

- k=
