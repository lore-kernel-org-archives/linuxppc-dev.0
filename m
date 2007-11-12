Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 79A47DDE29
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 07:24:39 +1100 (EST)
Subject: Re: [RFC] powermac: proper sleep management
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1194885177.5229.45.camel@johannes.berg>
References: <1194523729.6294.18.camel@johannes.berg>
	<1194814773.6510.23.camel@pasglop>
	<1194885177.5229.45.camel@johannes.berg>
Content-Type: text/plain
Date: Tue, 13 Nov 2007 07:24:01 +1100
Message-Id: <1194899041.18185.55.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linux-pm <linux-pm@lists.linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-11-12 at 17:32 +0100, Johannes Berg wrote:
> > Looks good to me, +/- a couple of things:
> > 
> >  - We _REALLY_ want the freezer to be optional and not enabled by
> > default on PowerPC. Maybe make it a compile option ?
> 
> Well, Alan is going to tell you that USB will break. If we need
> confirmation for that I can do the test he suggested to you or Paul a
> while ago.

Then USB is broken today on powermacs and need to be fixed. We had a
clear agreement at KS this year that the freezer was at best a band-aid
and that drivers -had- to be fixed to cope regardless.

> Obviously. I don't have any of that. I'd appreciate if somebody could
> test on a 3400 powerbook to see if that pci config space save/restore
> stuff is really necessary or even interferes with the regular stuff.

Might not be that necessary anymore nowadays, the generic code ought to
do it, but I'll give a go, I have one of those (paulus old one) though
last I tried, the HD was dead.

Ben.
