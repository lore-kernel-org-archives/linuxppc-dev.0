Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B63F3DDFA8
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 08:37:23 +1100 (EST)
Date: Thu, 11 Jan 2007 22:37:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 3/7] Enable MSI on Powerpc
Message-ID: <20070111213708.GC23237@lst.de>
References: <1168514716.63474.857278133999.qpush@cradle>
	<20070111112503.920E6DDEBE@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070111112503.920E6DDEBE@ozlabs.org>
Cc: Olof Johannsson <olof@lixom.net>, Greg Kroah-Hartman <greg@kroah.com>,
	linux-pci@atrey.karlin.mff.cuni.cz,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -# Build the PCI MSI interrupt support
> +# Build the PCI MSI interrupt support, but not for arch/powerpc
> +ifndef CONFIG_PPC_MERGE
>  obj-$(CONFIG_PCI_MSI) += msi.o
> +endif

This is not very nice.  I'd rather prefer this code beeing funnel in
through your higher level code.
