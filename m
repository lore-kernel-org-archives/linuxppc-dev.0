Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 42DD5DDE03
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2008 13:48:09 +1100 (EST)
Subject: Re: [PATCH] net: NEWEMAC: Remove "rgmii-interface" from rgmii
	matching table
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20080206163554.GA18575@lixom.net>
References: <1202300519-7294-1-git-send-email-sr@denx.de>
	<20080206160157.GA18228@lixom.net>
	<20080206102340.1cdf7f8d@zod.rchland.ibm.com>
	<20080206163554.GA18575@lixom.net>
Content-Type: text/plain
Date: Thu, 07 Feb 2008 13:47:28 +1100
Message-Id: <1202352448.7079.112.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>, jeff@garzik.org,
	netdev@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-02-06 at 10:35 -0600, Olof Johansson wrote:
> On Wed, Feb 06, 2008 at 10:23:40AM -0600, Josh Boyer wrote:
> > On Wed, 6 Feb 2008 10:01:57 -0600
> > Olof Johansson <olof@lixom.net> wrote:
> > 
> > > On Wed, Feb 06, 2008 at 01:21:59PM +0100, Stefan Roese wrote:
> > > > With the removal the the "rgmii-interface" device_type property from the
> > > > dts files, the newemac driver needs an update to only rely on compatible
> > > > property.
> > > 
> > > What about systems using an older dts, such as one kexec:ing from an
> > > older kernel?
> > 
> > Like what?  Kexec doesn't work on 4xx yet.
> 
> Sure, but similar restrictions would apply for customers who have a
> flashed device tree that want to boot a newer kernel. Deprecating old
> device tree support is something that should be done very carefully.

In that case, we -know- there was no such thing as the proper support
for 4xx in powerpc isn't really there before 2.6.25 anyway. The only
other is Cell/Axon which we verified still works.

Ben.
