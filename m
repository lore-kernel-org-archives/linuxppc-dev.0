Return-Path: <greg@kroah.com>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BC62CDDDEF
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 11:58:10 +1100 (EST)
Date: Thu, 6 Dec 2007 17:00:01 -0800
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] pci: Fix bus resource assignment on 32 bits with 64b
	resources
Message-ID: <20071207010001.GA23575@kroah.com>
References: <20071205064116.D849BDE10A@ozlabs.org>
	<1196911347.7033.15.camel@pasglop>
	<20071206063940.GA16474@kroah.com>
	<1196927934.7033.39.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1196927934.7033.39.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 06, 2007 at 06:58:54PM +1100, Benjamin Herrenschmidt wrote:
> 
> On Wed, 2007-12-05 at 22:39 -0800, Greg KH wrote:
> > > that is  it can be either unsigned int, unsigned long or unsigned
> > long
> > > long... and we have no way to reliably printk that.
> > 
> > We do this already just fine.  Take a look in the kernel, I think we
> > just always cast it to long long to be uniform.
> 
> I wanted to avoid that for two reasons:
> 
>  - casts are fugly
>  - it adds support code to cast & handle 64 bits to 32 bits platforms
>    that wouldn't normally need it

But that is how we already handle this today, in numerous places in the
kernel for this very type.

So, you can disagree that this is what we need to do, and if so, feel
free to fix up a whole lot of files in the tree :)

thanks,

greg k-h
