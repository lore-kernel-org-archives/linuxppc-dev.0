Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D112C681BB
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Jan 2006 05:21:47 +1100 (EST)
Date: Sat, 14 Jan 2006 19:12:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Remove powermac support from ARCH=ppc
Message-ID: <20060114181235.GA25578@lst.de>
References: <17352.57423.119068.737164@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17352.57423.119068.737164@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jan 14, 2006 at 10:28:15PM +1100, Paul Mackerras wrote:
> This patch makes it possible to build kernels for PReP and/or CHRP
> with ARCH=ppc by removing the (non-building) powermac support.
> It's now also possible to select PReP and CHRP independently.
> Powermac users should now build with ARCH=powerpc instead of
> ARCH=ppc.
> 
> This patch doesn't actually remove all the powermac files under
> arch/ppc, but they could go.
> 
> This means, BTW, that it will no longer be possible to build 32-bit
> kernels for Apple G5 machines.  Also, miboot users (are there any
> still?) are out of luck until I move the miboot stuff over to
> arch/powerpc/boot.

Can we please make arch/powerpc the defaul for native builds with uname
== ppc now that all interesting workstation class machines are supported
better by arch/powerpc?  Else this patch will be rather painfull for
those building their own kernels.
