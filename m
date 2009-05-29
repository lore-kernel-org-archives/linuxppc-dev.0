Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 12297DDF84
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 17:23:29 +1000 (EST)
Subject: Re: [RFC][PATCH] powerpc/pci: Pull ppc32 code we need in ppc64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1242803331.16901.188.camel@pasglop>
References: <Pine.LNX.4.64.0904291546130.19681@localhost.localdomain>
	<A254D12F-2709-48BB-8E7B-2F82D45D1372@kernel.crashing.org>
	<1242803331.16901.188.camel@pasglop>
Content-Type: text/plain
Date: Fri, 29 May 2009 17:18:44 +1000
Message-Id: <1243581524.17903.34.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-05-20 at 17:08 +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2009-05-20 at 00:57 -0500, Kumar Gala wrote:
> > Ben,
> > 
> > Comments on the pmac case?
> 
> Not yet :-) Give me a day. Was tracking a bug today.

A few days later...

Looks good. I had a quick peek at powermac users of the early ops and
they all seem to have a valid "hose".

Cheers,
Ben.
