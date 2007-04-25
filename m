Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D5D37DDF8A
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 23:07:42 +1000 (EST)
In-Reply-To: <20070424.212736.115930755.davem@davemloft.net>
References: <f64705c9250a93dcb7a4015b9a0d5667@kernel.crashing.org>
	<1177459397.14873.160.camel@localhost.localdomain>
	<baa646899e4d0f3f1111f62709a2c66b@kernel.crashing.org>
	<20070424.212736.115930755.davem@davemloft.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ea3c9c86088acd4145b02a972530711d@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/6] Start split out of common open firmware code
Date: Wed, 25 Apr 2007 15:07:34 +0200
To: David Miller <davem@davemloft.net>
Cc: sfr@canb.auug.org.au, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> The SPARC tree carries the same broken code -- is
>> this just a case of code copying, or are there
>> actual SPARC machines with such broken trees?
>
> There have been many cases of missed or even erroneous
> properties on sparc tree, but I am not too sure about
> the cell counting cases.
>
> Let's do this, once the consolidation is done keeping
> behavior as-is, give me a patch to review that changing
> the cell counting bits and I'll verify it against
> all the machines I have here plus some OFW tree dumps.

Okay, good plan.  Let's try this as soon as the current
patch series hits the powerpc tree.


Segher
