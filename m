Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7B789DDDDB
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Oct 2008 14:19:54 +1000 (EST)
Subject: Re: [PATCH] powerpc: Simple platform for the ISS 4xx simulator
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sean MacLennan <smaclennan@pikatech.com>
In-Reply-To: <20081002210254.09076765@lappy.seanm.ca>
References: <20081003000737.85CFEDDE17@ozlabs.org>
	<20081002210254.09076765@lappy.seanm.ca>
Content-Type: text/plain
Date: Fri, 03 Oct 2008 14:19:44 +1000
Message-Id: <1223007584.12264.170.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-10-02 at 21:02 -0400, Sean MacLennan wrote:
> On Fri, 03 Oct 2008 10:07:19 +1000
> "Benjamin Herrenschmidt" <benh@kernel.crashing.org> wrote:
> 
> >  image-$(CONFIG_WARP)			+= cuImage.warp
> > -image-$(CONFIG_YOSEMITE)		+= cuImage.yosemite
> > +image-$(CONFIG_YOSEMITE)		+= cuImage.yosemit
> 
> Did you really mean to drop the e from yosemite?

Nope :-) Thanks for catching this.

Cheers,
Ben.
