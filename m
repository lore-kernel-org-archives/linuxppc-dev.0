Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E0483DDDF9
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 08:33:10 +1100 (EST)
Date: Mon, 12 Mar 2007 22:32:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: Re: [PATCH 1/2] [powerpc] export symbols for use by lparcfg
Message-ID: <20070312213258.GA13648@lst.de>
References: <20070312192114.16630.90671.stgit@joxer.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070312192114.16630.90671.stgit@joxer.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 12, 2007 at 01:21:14PM -0600, Will Schmidt wrote:
> 
> Updates the Kconfig to allow lparcfg to be built as a module, and
> add the necessary EXPORT_SYMBOLS needed for a successful build.
> 
> Signed-off-by: Will Schmidt <will_schmidt@vnet.ibm.com>

NACK.  This is an awfull lot of deep down internal symbols, and there
is no reason to make this a module.  If you fear about the space useage
on non-phype platforms better reintroduce something like the
__pmac/__chrp markers of the old ppc32 port.
