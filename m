Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 10135DDF05
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 19:26:34 +1000 (EST)
In-Reply-To: <1177378169.14873.46.camel@localhost.localdomain>
References: <1176968125.531108.326168797246.qpush@cradle>
	<20070419073555.D2C3EDDEFD@ozlabs.org>
	<20070423035025.GA29839@lixom.net>
	<1177378169.14873.46.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f5dd623fbb338d38bc05567ee178b886@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 6/7] MPIC MSI allocator
Date: Tue, 24 Apr 2007 11:26:26 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> It's time to rename BROKEN_U3. It used to be the config option to 
>> enable
>> a few workarounds, but now it's used to select whenever there's a U3 
>> in
>> the system. Care to do it in the scope of this patch set?
>
> Not really.... first gen G5s don't use that :-) It's wether the MPIC is
> part of U3/U4 -and- is used as a primary HT PIC.

Not really...  It is whether the HT-to-MPIC interface
on the U3/U4 has the "feature" that ack-required
interrupts coming in over HT need to be acked by hand.

First-gen G5's need that just as well, they just don't
have such interrupts on the default system configuration,
as far as I remember.


Segher
