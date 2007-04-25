Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 2EB9CDDF34
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 08:24:12 +1000 (EST)
Date: Wed, 25 Apr 2007 15:24:19 -0700 (PDT)
Message-Id: <20070425.152419.110959714.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 3/6] Consolidate of_find_property
From: David Miller <davem@davemloft.net>
In-Reply-To: <1177539404.14873.199.camel@localhost.localdomain>
References: <c249005137aa3e50c25221f6849a70ea@kernel.crashing.org>
	<462F93F0.5090608@genesi-usa.com>
	<1177539404.14873.199.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 26 Apr 2007 08:16:44 +1000

> On Wed, 2007-04-25 at 18:46 +0100, Matt Sealey wrote:
> 
> > Can't the ata/ATA thing be fixed by simply fixing device trees where it
> > happens? strncmp seems the standards-compliant route to take.. why clutter
> > the common parsing routines with fixes for deviant platforms?
> 
> In that specific case, it's even fixed by having the driver have both
> spellings in it's match list.

This is something I'd like to avoid.

Initially I added sparc OFW property support to the Radeon
driver by checking for both the upper-case and lower-case
variants of all the property names.

It was beyond ugly.

I know we are talking about node names, not properties, here but
I think the same logic and reasoning applies.

> But I agree that in the long run, it's a better approach

Maybe.
