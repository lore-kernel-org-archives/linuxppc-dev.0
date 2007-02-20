Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 57B9FDDE03
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 02:11:50 +1100 (EST)
In-Reply-To: <1171983806.24204.79.camel@zod.rchland.ibm.com>
References: <20070220020837.GF17818@localhost.localdomain>
	<1171980307.24204.66.camel@zod.rchland.ibm.com>
	<200702201516.25160.arnd@arndb.de>
	<1171982767.24204.70.camel@zod.rchland.ibm.com>
	<1171983806.24204.79.camel@zod.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9e2ee8c310b7adb1040d7847d0d4b1dd@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [0/14] Ebony support, 2nd spin
Date: Tue, 20 Feb 2007 16:11:41 +0100
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> We should look for both "ns16550" and "ns16750" compatible devices in
> legacy_serial.c.

And 16450 and 8250.

> As for the bus type, we could look for both types or
> the ebony.dts could change to use "opb" instead of "ibm,opb".

The "IBM," name is OF best practice so please keep it.


Segher
