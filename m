Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3A5DD679A6
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Dec 2006 21:05:01 +1100 (EST)
In-Reply-To: <1165618381.1103.89.camel@localhost.localdomain>
References: <20061208114113.2191e446@localhost>
	<1165618381.1103.89.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <F6853CAA-5CBD-4BA8-A330-55D66AB3E853@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch] powerpc: add scanning of ebc bus to of_platform
Date: Sat, 9 Dec 2006 11:04:34 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christian Krafft <krafft@de.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I'd like other people opinions here... But I'm tempted to remove the
> "default" list of bus types here and have it always be passed by the
> platform... just in case.

That's probably best -- no sense in registering devices
on buses that the platform doesn't know how to drive!


Segher
