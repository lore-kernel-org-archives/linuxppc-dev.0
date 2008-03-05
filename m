Return-Path: <greg@kroah.com>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2F2A7DE2DD
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Mar 2008 07:17:21 +1100 (EST)
Date: Wed, 5 Mar 2008 12:14:26 -0800
From: Greg KH <greg@kroah.com>
To: David Howells <dhowells@redhat.com>
Subject: Re: [patch 01/16] PCI: add generic pci_enable_resources()
Message-ID: <20080305201426.GD13569@kroah.com>
References: <20080304185819.885549413@ldl.fc.hp.com>
	<20080304185646.864917286@ldl.fc.hp.com>
	<20894.1204728811@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20894.1204728811@redhat.com>
Cc: linux-arch@vger.kernel.org, Chris Zankel <chris@zankel.net>,
	Grant Grundler <grundler@parisc-linux.org>,
	linux-parisc@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-arm-kernel@lists.arm.linux.org.uk,
	Russell King <rmk@arm.linux.org.uk>, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 05, 2008 at 02:53:31PM +0000, David Howells wrote:
> 
> Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> 
> > Each architecture has its own pcibios_enable_resources() implementation.
> > These differ in many minor ways that have nothing to do with actual
> > architectural differences.  Follow-on patches will make most arches
> > use this generic version instead.
> > 
> > This version is based on powerpc, which seemed most up-to-date.  The only
> > functional difference from the x86 version is that this uses "!r->parent"
> > to check for resource collisions instead of "!r->start && r->end".
> > 
> > Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
> Acked-by: David Howells <dhowells@redhat.com>

added, thanks.

greg k-h
