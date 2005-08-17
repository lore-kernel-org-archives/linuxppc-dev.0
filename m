Return-Path: <rmk+linuxppc-dev=ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[212.18.232.186])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 62D3667F91
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Aug 2005 02:46:11 +1000 (EST)
Date: Wed, 17 Aug 2005 17:46:00 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Message-ID: <20050817174600.A22040@flint.arm.linux.org.uk>
References: <1124209292.3869.5.camel@localhost.localdomain>
	<20050817121128.A19990@flint.arm.linux.org.uk>
	<1124296771.3869.74.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1124296771.3869.74.camel@localhost.localdomain>;
	from dwmw2@infradead.org on Wed, Aug 17, 2005 at 05:39:30PM +0100
Sender: Russell King <rmk@arm.linux.org.uk>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Use platform device for 8250 registration
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 17, 2005 at 05:39:30PM +0100, David Woodhouse wrote:
> On Wed, 2005-08-17 at 12:11 +0100, Russell King wrote:
> > Doesn't PPC64 have NO_IRQ ?
> 
> PPC64 does but I find no definition of is_real_interrupt() other than
> the bogus one in 8250.c which checks for zero. PPC32 does not -- let's
> clean that one up separately.

Ok.  I'll give you this line now for this patch:

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

so you're free to push it upstream whenever you deem is the right time.
Thanks.

-- 
Russell King
