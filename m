Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F0A5ADDE10
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Aug 2007 12:31:38 +1000 (EST)
Subject: Re: Page faults blowing up ... [was Re: [PATCH] Fix special PTE
	code for secondary hash bucket
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20070803193258.GA9613@austin.ibm.com>
References: <18098.61003.38084.554299@cargo.ozlabs.ibm.com>
	<20070803193258.GA9613@austin.ibm.com>
Content-Type: text/plain
Date: Sat, 04 Aug 2007 12:31:28 +1000
Message-Id: <1186194688.5733.6.camel@gruick>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, benh@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-08-03 at 14:32 -0500, Linas Vepstas wrote:
> On Fri, Aug 03, 2007 at 06:58:51PM +1000, Paul Mackerras wrote:
> > The code for mapping special 4k pages on kernels using a 64kB base
> > page size was missing the code for doing the RPN (real page number)
> > manipulation when inserting the hardware PTE in the secondary hash
> > bucket.  It needs the same code as has already been added to the
> > code that inserts the HPTE in the primary hash bucket.  This adds it.
> 
> So what are the symptoms of hitting this? Does this affect only 
> recent kernels, or old ones too?

Paulus stuff is likely to be unrelated to your bug. Also, whatever blurb
you pasted in this email is totally incomprehensible due to total lack
of context.

Ben.
