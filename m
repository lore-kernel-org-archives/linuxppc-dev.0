Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 75F26DDE11
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 11:53:53 +1000 (EST)
Subject: Re: [PATCH] powerpc: rework 4xx PTE access and TLB miss
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sean MacLennan <smaclennan@pikatech.com>
In-Reply-To: <20080708205315.4e463bdb@lappy.seanm.ca>
References: <20080708055449.EDFDADDEF5@ozlabs.org>
	<20080708205315.4e463bdb@lappy.seanm.ca>
Content-Type: text/plain
Date: Wed, 09 Jul 2008 11:53:46 +1000
Message-Id: <1215568426.8970.296.camel@pasglop>
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

On Tue, 2008-07-08 at 20:53 -0400, Sean MacLennan wrote:
> On Tue, 08 Jul 2008 15:54:40 +1000
> "Benjamin Herrenschmidt" <benh@kernel.crashing.org> wrote:
> 
> > This is some preliminary work to improve TLB management on SW loaded
> > TLB powerpc platforms. This introduce support for non-atomic PTE
> > operations in pgtable-ppc32.h and removes write back to the PTE from
> > the TLB miss handlers. In addition, the DSI interrupt code no longer
> > tries to fixup write permission, this is left to generic code, and
> > _PAGE_HWWRITE is gone.
> 
> Ok, this version booted for me and passed some very rudimentary
> regression tests.

Thanks for testing.

Cheers,
Ben.
