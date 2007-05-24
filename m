Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8A907DDDEB
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 19:13:54 +1000 (EST)
In-Reply-To: <20070524055909.GG20078@localhost.localdomain>
References: <20070524041625.GD20078@localhost.localdomain>
	<BB9A8C3A-0BC5-4DF0-9201-2742124A4AF5@kernel.crashing.org>
	<20070524055909.GG20078@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7e14fb6736fbd0b77774ce10417d627d@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Fix problems with Holly's DT representation of ethernet PHYs
Date: Thu, 24 May 2007 11:13:46 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexandre Bounine <Alexandre.Bounine@tundra.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Is the compatible really need here?  We are able to provide and bind
>> drivers based on MII_PHYSID1/2.  I don't see what putting the
>> compatible proper gets us.
>
> That's a good point (except that having a node without compatible is
> kind of odd).

Not really; "compatible" is for the cases where "name"
alone isn't enough.

> At the moment the code which instantiates the platform
> device looks at compatible to enable a workaround.  But actually that
> workaround is holly specific, rather than related to the PHY model,
> and so should be encoded differently.

There is no real value in encoding it in the device
tree, even.


Segher
