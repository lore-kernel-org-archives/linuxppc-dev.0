Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 17657DDF6E
	for <linuxppc-dev@ozlabs.org>; Mon, 28 May 2007 21:08:01 +1000 (EST)
In-Reply-To: <1180316317.19517.51.camel@localhost.localdomain>
References: <20070524041625.GD20078@localhost.localdomain>
	<BB9A8C3A-0BC5-4DF0-9201-2742124A4AF5@kernel.crashing.org>
	<1180014260.3360.14.camel@zod.rchland.ibm.com>
	<20070525042359.GE13575@localhost.localdomain>
	<20070525043728.GG13575@localhost.localdomain>
	<20070525043852.GH13575@localhost.localdomain>
	<25433b8fc06678e73ee055ed4f44f7a3@kernel.crashing.org>
	<20070527233031.GB23768@localhost.localdomain>
	<1180316317.19517.51.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <707c0e95390db3244bf6ebc0cbe95454@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Fix problems with Holly's DT representation of ethernet PHYs
Date: Mon, 28 May 2007 13:07:51 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alexandre Bounine <Alexandre.Bounine@tundra.com>,
	David Gibson <dwg@au1.ibm.com>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> In that case however, the 54xx are fairly different from each other, so
> please use something more specific.

_Never_ use the "xx" stuff, it's meaningless.


Segher
