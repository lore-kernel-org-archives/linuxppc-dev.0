Return-Path: <greg@kroah.com>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4DBCEDDEFE
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 10:56:00 +1100 (EST)
Date: Fri, 1 Feb 2008 15:34:09 -0800
From: Greg KH <greg@kroah.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 1/2] pci: Fix bus resource assignment on 32 bits with
	64b resources
Message-ID: <20080201233409.GB24676@kroah.com>
References: <20071210063216.89DBBDDE1E@ozlabs.org>
	<200802011118.57610.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200802011118.57610.sr@denx.de>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 01, 2008 at 11:18:56AM +0100, Stefan Roese wrote:
> On Monday 10 December 2007, Benjamin Herrenschmidt wrote:
> > The current pci_assign_unassigned_resources() code doesn't work properly
> > on 32 bits platforms with 64 bits resources. The main reason is the use
> > of unsigned long in various places instead of resource_size_t.
> >
> > This fixes it, along with some tricks to avoid casting to 64 bits on
> > platforms that don't need it in every printk around.
> >
> > This is a pre-requisite for making powerpc use the generic code instead of
> > its own half-useful implementation.
> >
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Checking Linus's latest git repository, it seems this patch (and the 2nd from 
> this series) hasn't been applied till now. This is just a reminder, that it 
> gets in in this merge-window.

Just got sent to him...

thanks,

greg k-h
