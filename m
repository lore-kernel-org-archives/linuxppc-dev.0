Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 56E6EDDEDB
	for <linuxppc-dev@ozlabs.org>; Sat, 26 May 2007 00:12:06 +1000 (EST)
In-Reply-To: <20070525043852.GH13575@localhost.localdomain>
References: <20070524041625.GD20078@localhost.localdomain>
	<BB9A8C3A-0BC5-4DF0-9201-2742124A4AF5@kernel.crashing.org>
	<1180014260.3360.14.camel@zod.rchland.ibm.com>
	<20070525042359.GE13575@localhost.localdomain>
	<20070525043728.GG13575@localhost.localdomain>
	<20070525043852.GH13575@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <25433b8fc06678e73ee055ed4f44f7a3@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Fix problems with Holly's DT representation of ethernet PHYs
Date: Fri, 25 May 2007 16:11:59 +0200
To: David Gibson <dwg@au1.ibm.com>
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

> Waah!  Third time lucky?

You wish :-)

> 	- Second, the PHYs give only "bcm54xx" as a compatible
> property.  This is unfortunate, because there are many bcm54xx PHY
> models, and they have differences which can matter.  We add a more
> precise compatible string, giving the precise PHY model (bcm5461A in
> this case).

You completely removed the "compatible" properties instead.
Bad idea.


Segher
