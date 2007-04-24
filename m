Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 83DD1DDF13
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 19:44:43 +1000 (EST)
In-Reply-To: <1177407551.14873.105.camel@localhost.localdomain>
References: <1176968125.531108.326168797246.qpush@cradle>
	<20070419073555.D2C3EDDEFD@ozlabs.org>
	<20070423035025.GA29839@lixom.net>
	<1177378169.14873.46.camel@localhost.localdomain>
	<f5dd623fbb338d38bc05567ee178b886@kernel.crashing.org>
	<1177407551.14873.105.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <dbba27bc913250681a57be91605e25f2@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 6/7] MPIC MSI allocator
Date: Tue, 24 Apr 2007 11:44:37 +0200
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

>> First-gen G5's need that just as well, they just don't
>> have such interrupts on the default system configuration,
>> as far as I remember.
>
> They didn't have an HT APIC or if they had one, they didn't enable it
> (they probably did in the tunnel).

Yes, the two HT APICs on the tunnel were enabled.

> They didn't use the U3 MPIC as an HT
> IRQ master, thus it's irrelevant.

They did for the plugin PCI-X slots (well, it's chained
to another MPIC, but you still need the workaround).

> Anyway, there is no point in this
> discussion :-)

Yeah, the new name for CONFIG_BROKEN_U3 is fine
no matter what :-)


Segher
