Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 059ACDDEDB
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Feb 2007 03:55:07 +1100 (EST)
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302A59633@az33exm25.fsl.freescale.net>
References: <b16b3a03ce9b890909b3f64f50e78b75@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A592C7@az33exm25.fsl.freescale.net>
	<20070222225707.GB15387@localhost.localdomain>
	<621751322ddfe998a15538e8d3903b93@kernel.crashing.org>
	<20070223003317.GA18508@localhost.localdomain>
	<1be2170fcb25fdc4ac52c93444269737@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A59633@az33exm25.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <851c62f4acae2d5c9b2d1eeab20bdd47@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: document new interrupt-array property
Date: Fri, 23 Feb 2007 17:55:00 +0100
To: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> we need something like interrupt-array.
>>
>> Again, the "interrupt-array" helps only this one specific
>> case, and not the general case *at all*.
>>
>
> Yes-- The interrupt-array helps only this specific case. But
> the question is, will this specific case be common in the
> future?

I hope (and think) not.  I can't predict the future though
and there is an approximately 100% chance some hardware will
duplicate this particular weirdness, of course.

> If this is a one-off situation it doesn't warrant a new
> general property.  However, if it becomes common enough
> a simpler representation will benefit developers.

Sure.  But in that case, it would be a lot better to
try to come up with something new that can handle the
general case (or many many more cases at least).

> There are
> developers who have a hard enough time figuring out the
> interrupt-map scheme, much less a logical interrupt nexus
> node.

Adding redundant ways of representing the interrupt
mapping that only apply to minority cases doesn't help
the confusion.  Either educate users how to do things,
come up with a more general more flexible framework,
or both.  Interface explosion only makes the situation
_worse_.


Segher
