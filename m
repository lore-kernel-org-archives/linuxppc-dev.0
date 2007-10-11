Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 4F21BDDFD4
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 15:22:14 +1000 (EST)
Date: Thu, 11 Oct 2007 00:27:31 -0500
From: Olof Johansson <olof@lixom.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 3/7] [POWERPC] remove iSeries_vio_dev
Message-ID: <20071011052731.GB578@lixom.net>
References: <20071011144824.a5e3de59.sfr@canb.auug.org.au>
	<20071011145055.1de13742.sfr@canb.auug.org.au>
	<20071011145332.e3638c2e.sfr@canb.auug.org.au>
	<20071011052535.GA578@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071011052535.GA578@lixom.net>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org,
	Jens Axboe <jens.axboe@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 11, 2007 at 12:25:35AM -0500, Olof Johansson wrote:
> Hi Stephen,
> 
> > @@ -189,6 +191,34 @@ void iommu_devnode_init_iSeries(struct pci_dev *pdev, struct device_node *dn)
> >  }
> >  #endif
> >  
> > +extern struct iommu_table vio_iommu_table;
> 
> This looks like it really should go in a header file
> instead. include/asm-powerpc/vio.h perhaps?

Oh nevermind, I just noticed the variable got moved in the next
patch. Twice the review work!


-Olof
