Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 76BB1DDF84
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 13:49:45 +1100 (EST)
Date: Fri, 26 Jan 2007 03:49:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/1] powerpc: Export PCI slot reset API
Message-ID: <20070126024924.GA18537@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 12, 2007 at 02:49:32PM -0600, Brian King wrote:
> 
> Adds two new APIs to assert/deassert PCI reset to a given
> device. This is needed for an ipr PCI-E adapter which does not
> properly implement either BIST nor PCI-E hot reset, requiring
> a PCI-E warm reset, which is what this implements.

Having this exported only on a single platform is wrong. Any API
for PCI drivers should be implemented on all platforms, even if
some of it have it stubbed out.
