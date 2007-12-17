Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 5123BDDE10
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Dec 2007 10:31:18 +1100 (EST)
Date: Mon, 17 Dec 2007 17:37:18 -0600
From: Olof Johansson <olof@lixom.net>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] [POWERPC] pasemi: export pasemi_dma_init()
Message-ID: <20071217233718.GA23404@lixom.net>
References: <20071214080655.GA27284@lixom.net> <47670547.7000701@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47670547.7000701@pobox.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 17, 2007 at 06:24:55PM -0500, Jeff Garzik wrote:
> > Index: 2.6.24/arch/powerpc/platforms/pasemi/dma_lib.c
> > ===================================================================
> > --- 2.6.24.orig/arch/powerpc/platforms/pasemi/dma_lib.c
> > +++ 2.6.24/arch/powerpc/platforms/pasemi/dma_lib.c
> > @@ -485,3 +485,4 @@ out:
> >  	spin_unlock(&init_lock);
> >  	return err;
> >  }
> > +EXPORT_SYMBOL(pasemi_dma_init);
> 
> For .24 (#upstream-fixes) or .25 (#upstream)?

.25, the code isn't there in .24.


Thanks,

Olof
