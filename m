Return-Path: <dhowells@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 731B2DDFE6
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Mar 2008 02:02:49 +1100 (EST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20080304185819.885549413@ldl.fc.hp.com>
References: <20080304185819.885549413@ldl.fc.hp.com>
	<20080304185646.864917286@ldl.fc.hp.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 01/16] PCI: add generic pci_enable_resources()
Date: Wed, 05 Mar 2008 14:53:31 +0000
Message-ID: <20894.1204728811@redhat.com>
Sender: dhowells@redhat.com
Cc: linux-arch@vger.kernel.org, Chris Zankel <chris@zankel.net>,
	Grant Grundler <grundler@parisc-linux.org>,
	linux-parisc@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-arm-kernel@lists.arm.linux.org.uk,
	Russell King <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> Each architecture has its own pcibios_enable_resources() implementation.
> These differ in many minor ways that have nothing to do with actual
> architectural differences.  Follow-on patches will make most arches
> use this generic version instead.
> 
> This version is based on powerpc, which seemed most up-to-date.  The only
> functional difference from the x86 version is that this uses "!r->parent"
> to check for resource collisions instead of "!r->start && r->end".
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Acked-by: David Howells <dhowells@redhat.com>
