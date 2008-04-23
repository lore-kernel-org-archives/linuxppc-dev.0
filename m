Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6D2FBDDFC6
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 14:40:54 +1000 (EST)
Subject: Re: [PATCH v3] powerpc: Add irqtrace support for 32-bit powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1207690574.7442.4.camel@johannes.berg>
References: <20080404213932.GA15847@farnsworth.org>
	<20080407171428.GA14900@farnsworth.org>
	<1207670643.5550.11.camel@johannes.berg>
	<1207690574.7442.4.camel@johannes.berg>
Content-Type: text/plain
Date: Wed, 23 Apr 2008 14:40:39 +1000
Message-Id: <1208925639.9060.16.camel@pasglop>
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


On Tue, 2008-04-08 at 23:36 +0200, Johannes Berg wrote:
> > > This version fixes the clobbering of r12 by the call to
> > > trace_hardirqs_off() that was pointed out by BenH.
> > > 
> > > Johannes, I'd appreciate your trying this version if/when
> > > you get the chance.
> > 
> > Thanks Dale, this version seems to work. I'll stress it a bit more
> > later, but so far it has survived *much* longer than both previous
> > versions.
> 
> Hmm. Bad news. I got a crash in console_callback() again where
> apparently r28 had a bogus value. That, however, doesn't make sense, so
> maybe that register value was calculated from another register.

Possibly. How hard was it to reproduce ? Could it be a bug unrelated to
lockdep ?

Ben.
