Return-Path: <mporter@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 26ED467C43
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Aug 2006 23:14:06 +1000 (EST)
Date: Thu, 24 Aug 2006 08:26:10 -0500
From: Matt Porter <mporter@embeddedalley.com>
To: Josh Boyer <jdub@us.ibm.com>
Subject: Re: ARCH=ppc or ARCH=powerpc
Message-ID: <20060824132610.GB27468@gate.crashing.org>
References: <20060824123841.4756.qmail@web36601.mail.mud.yahoo.com>
	<1156423796.5640.23.camel@zod.rchland.ibm.com>
	<1156424295.19482.11.camel@localhost>
	<1156424840.5640.27.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1156424840.5640.27.camel@zod.rchland.ibm.com>
Cc: BDE@teamlog.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Aug 24, 2006 at 08:07:20AM -0500, Josh Boyer wrote:
> On Thu, 2006-08-24 at 14:58 +0200, Benjamin Delagoutte wrote:
> > What about the includes ? Do I have to use only include/asm-ppc or are
> > include/asm-powerpc necessary as well ?
> 
> I believe there are some hacks in the makefiles to pull common asm files
> from include/asm-powerpc when needed.  Basically, you should be able to
> just do:
> 
> #include <asm/foo.h>
> 
> and it should work.  If you're adding new .h files, I suppose asm-ppc is
> the place to add them for now.  That's just my opinion though :)

That's what I would recommend too. If this is for an out-of-tree custom
port then there's no real concern anyway.

-Matt
