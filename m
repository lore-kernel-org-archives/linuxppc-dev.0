Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 23767DDEF7
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 09:37:29 +1100 (EST)
Subject: Re: [PATCH] pci: Fix bus resource assignment on 32 bits with 64b
	resources
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthew Wilcox <matthew@wil.cx>
In-Reply-To: <20071206081628.GA15868@parisc-linux.org>
References: <20071205064116.D849BDE10A@ozlabs.org>
	<1196911347.7033.15.camel@pasglop> <20071206063940.GA16474@kroah.com>
	<1196927934.7033.39.camel@pasglop>
	<20071206081628.GA15868@parisc-linux.org>
Content-Type: text/plain
Date: Fri, 07 Dec 2007 09:37:05 +1100
Message-Id: <1196980625.6599.3.camel@pasglop>
Mime-Version: 1.0
Cc: Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> It's been discussed before.  Some of the solutions discussed:
> 
>  - Add something like PRI_RES which can be concatenated into a printk.
>    Ugly.
>  - Patch gcc to allow user-definable types.  I think OpenBSD has a patch
>    for this.  Then we have to get that patch propagated to all the
>    people who compile the kernel.  Unappetising.
>  - Disable gcc's printk checking, teach sparse to typecheck printk.
>    Most people don't run sparse yet.

So you seem to dislike all 3, which one do you dislike the less ?

Cheers,
Ben.
