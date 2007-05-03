Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 21031DE04C
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 10:54:18 +1000 (EST)
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302D5E1A9@az33exm25.fsl.freescale.net>
References: <e359e43198096bc73cdac058c6e5ad6d@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302D5DC6F@az33exm25.fsl.freescale.net>
	<567cddf8855d809f2e0c5b4101c2c15a@kernel.crashing.org>
	<20070502011957.GA12876@localhost.localdomain>
	<9696D7A991D0824DBA8DFAC74A9C5FA302D5E1A9@az33exm25.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <64b567074d4660a24a779e3e078dfb3a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: RFC: new device types in the device tree (RE: [PATCH] powerpc:
	Add EDAC platform devices for 85xx)
Date: Thu, 3 May 2007 02:54:11 +0200
To: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
Cc: linuxppc-dev@ozlabs.org, bluesmoke-devel@lists.sourceforge.net,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> But, don't we want to keep standardized sets of properties for
> certain classes/types of devices?

Sure.

> Defining a standardized,
> required set of properties for a "network", "rom", or "i2c"
> class of device is helpful.

Only if such a device binding is generic enough to actually
handle all such devices.  Sure a specific device may have
some extra properties, but all the basic stuff should be
in standard properties.

> Without a standardized 'template'
> of properties, developers may make up whatever properties they
> want and things will work fine as long as the device tree and
> driver are in sync.  It works, but you wind up with a plethora
> of properties each describing the same thing.

You might think this is bad, but IMO it is better to
have several drivers doing similar things in different
ways, than to force all drivers to use a binding that
doesn't fit them well.

> If we do away with device_type,
> what is it that defines a particular node to be a certain class
> of device.

The matching device driver knows (and it knows a great
deal more about the device, hopefully ;-) )


Segher
