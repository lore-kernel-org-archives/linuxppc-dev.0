Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4C044DDE38
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Jun 2007 17:37:28 +1000 (EST)
In-Reply-To: <1180826202.14025.12.camel@localhost.localdomain>
References: <1180720112.14219.62.camel@ld0161-tx32>
	<dfc15991e31bfc09389461dc443acd7c@kernel.crashing.org>
	<E1HuGfE-0007zw-EH@jdl.com>
	<1180743742.19517.485.camel@localhost.localdomain>
	<e2020ffad171013c07f8809e1e1aef97@kernel.crashing.org>
	<E1HuW61-00049R-FI@jdl.com>
	<27807251665003e059b2c39d2b700415@kernel.crashing.org>
	<1180826202.14025.12.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <fed89a6610a7defad7a18bbe5da8b33a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
Date: Sun, 3 Jun 2007 09:37:19 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Feel free to ask for advice on IRC, on the list, or
>> elsewhere _before_ sending a patch.
>
> Bah, sending a patch is good too, don't be too hard there. I for one
> prefer the approach of sending a patch first.

I'm saying that if you're unsure about stuff, you can ask
about it -- sending a preliminary patch with the question
is one way, sure.

>>> Second, perhaps there is lingering legacy
>>> crap in some of the early DTS files that should be systematically
>>> cleaned up.
>>
>> Yes there is.  Maybe one day I'll get to it, I'm hoping
>> someone else will fix this though ;-)
>
> We probably need to improve the documentation in fact. Maybe with a 
> step
> by step HOWTO create your device-tree with examples for typical things
> like PCI etc.. and the rational of why for each of these, we chose to 
> do
> XXX instead of YYY...

A howto-like doc would help yes.  Rationale might help people
better understand how things work, too, sure.

>> The official (and unofficial) Open Firmware docs are quite
>> good.  Perhaps we need a big huge fat sign in the DTS docs
>> pointing to them.
>
> They aren't -that- good when you come out of the blue and don't know
> where to start.

Well most people don't even know those docs _exist_ it
seems.

> I think a tutorial based on building a tree for an
> example board step by step would be best.

Would be nice yes.


Segher
