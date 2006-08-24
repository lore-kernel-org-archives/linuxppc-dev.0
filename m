Return-Path: <jdub@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A42D467BCD
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Aug 2006 23:06:49 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7OD6jl5008334
	for <linuxppc-embedded@ozlabs.org>; Thu, 24 Aug 2006 09:06:45 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7OD6jXx305314
	for <linuxppc-embedded@ozlabs.org>; Thu, 24 Aug 2006 07:06:45 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7OD6j7Y023060
	for <linuxppc-embedded@ozlabs.org>; Thu, 24 Aug 2006 07:06:45 -0600
Subject: Re: ARCH=ppc or ARCH=powerpc
From: Josh Boyer <jdub@us.ibm.com>
To: BDE@teamlog.com
In-Reply-To: <1156424295.19482.11.camel@localhost>
References: <20060824123841.4756.qmail@web36601.mail.mud.yahoo.com>
	<1156423796.5640.23.camel@zod.rchland.ibm.com>
	<1156424295.19482.11.camel@localhost>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 08:07:20 -0500
Message-Id: <1156424840.5640.27.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2006-08-24 at 14:58 +0200, Benjamin Delagoutte wrote:
> 
> I'm currently working on a PPC 405 based developement card. Does it mean
> I have to work using the arch/ppc tree ? 

For now, yes.  Set ARCH=ppc when you compile the kernel.

> What about the includes ? Do I have to use only include/asm-ppc or are
> include/asm-powerpc necessary as well ?

I believe there are some hacks in the makefiles to pull common asm files
from include/asm-powerpc when needed.  Basically, you should be able to
just do:

#include <asm/foo.h>

and it should work.  If you're adding new .h files, I suppose asm-ppc is
the place to add them for now.  That's just my opinion though :)

josh
