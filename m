Return-Path: <greg@kroah.com>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C26A7DDFC3
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Mar 2008 07:16:23 +1100 (EST)
Date: Wed, 5 Mar 2008 12:09:43 -0800
From: Greg KH <greg@kroah.com>
To: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [patch 09/16] parisc: use generic pci_enable_resources()
Message-ID: <20080305200943.GB13569@kroah.com>
References: <20080304185646.864917286@ldl.fc.hp.com>
	<20080304185821.554040328@ldl.fc.hp.com>
	<20080305161709.GA3354@phobos.i.cabal.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080305161709.GA3354@phobos.i.cabal.ca>
Cc: linux-arch@vger.kernel.org, Chris Zankel <chris@zankel.net>,
	Grant Grundler <grundler@parisc-linux.org>,
	linux-parisc@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-pci@atrey.karlin.mff.cuni.cz,
	Russell King <rmk@arm.linux.org.uk>, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 05, 2008 at 11:17:10AM -0500, Kyle McMartin wrote:
> On Tue, Mar 04, 2008 at 11:56:55AM -0700, Bjorn Helgaas wrote:
> > Use the generic pci_enable_resources() instead of the arch-specific code.
> > 
> > Unlike this arch-specific code, the generic version:
> >     - checks PCI_NUM_RESOURCES (11), not DEVICE_COUNT_RESOURCE (12), resources
> >     - skips resources that have neither IORESOURCE_IO nor IORESOURCE_MEM set
> >     - skips ROM resources unless IORESOURCE_ROM_ENABLE is set
> >     - checks for resource collisions with "!r->parent"
> > 
> > Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > 
> 
> Acked-by: Kyle McMartin <kyle@mcmartin.ca>

added, thanks.

greg k-h
