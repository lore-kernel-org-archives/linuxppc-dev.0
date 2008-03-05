Return-Path: <kyle@phobos.cabal.ca>
Received: from phobos.cabal.ca (206-248-169-182.dsl.ncf.ca [206.248.169.182])
	by ozlabs.org (Postfix) with ESMTP id 4A557DDFAF
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Mar 2008 03:17:12 +1100 (EST)
Date: Wed, 5 Mar 2008 11:17:10 -0500
From: Kyle McMartin <kyle@mcmartin.ca>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 09/16] parisc: use generic pci_enable_resources()
Message-ID: <20080305161709.GA3354@phobos.i.cabal.ca>
References: <20080304185646.864917286@ldl.fc.hp.com>
	<20080304185821.554040328@ldl.fc.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080304185821.554040328@ldl.fc.hp.com>
Cc: linux-arch@vger.kernel.org, Chris Zankel <chris@zankel.net>,
	Grant Grundler <grundler@parisc-linux.org>,
	linux-parisc@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-pci@atrey.karlin.mff.cuni.cz,
	Russell King <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 04, 2008 at 11:56:55AM -0700, Bjorn Helgaas wrote:
> Use the generic pci_enable_resources() instead of the arch-specific code.
> 
> Unlike this arch-specific code, the generic version:
>     - checks PCI_NUM_RESOURCES (11), not DEVICE_COUNT_RESOURCE (12), resources
>     - skips resources that have neither IORESOURCE_IO nor IORESOURCE_MEM set
>     - skips ROM resources unless IORESOURCE_ROM_ENABLE is set
>     - checks for resource collisions with "!r->parent"
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 

Acked-by: Kyle McMartin <kyle@mcmartin.ca>
