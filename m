Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 57EBADDEDB
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Jun 2007 02:04:58 +1000 (EST)
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts
	file.
In-Reply-To: Your message of "Sat, 02 Jun 2007 10:28:42 +0200."
	<e2020ffad171013c07f8809e1e1aef97@kernel.crashing.org>
References: <1180720112.14219.62.camel@ld0161-tx32>
	<dfc15991e31bfc09389461dc443acd7c@kernel.crashing.org>
	<E1HuGfE-0007zw-EH@jdl.com>
	<1180743742.19517.485.camel@localhost.localdomain>
	<e2020ffad171013c07f8809e1e1aef97@kernel.crashing.org>
Date: Sat, 02 Jun 2007 11:04:53 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1HuW61-00049R-FI@jdl.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Segher Boessenkool mumbled:
> 
> That, and I often get tired of seeing the same mistakes
> over and over again.  When I see a proposed tree that's
> just too awful I don't really know where to start.

That is a good point.

I think there are several factors at work here.  First and
foremost, I am not an expert in this area; it is new to me.
I am not afraid to say that I really need the guidance of
an expert here.  Second, perhaps there is lingering legacy
crap in some of the early DTS files that should be systematically
cleaned up.  Many of them were written during a time when we
were really first learning about the whole Device Tree.  While
they may have been there on some, say, Apple boards, it's all
new for the FSL embedded parts.  Cloned mistakes then likely
contributed to the problems and should be fixed.  Finally,
perhaps our documentation on how some of the important fields
should work or be derived is lacking and could be improved.
Suggestions or patches down this line would likely be welcomed.

> I also find the DTS source format a bit hard to read,
> but maybe that's just me.

I, at least, am open to suggestions that might improve it.

Thanks,
jdl
