Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CFFB6DDDA5
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 11:31:31 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n3S1VBES005952
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 18:31:22 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n3S1VAJm004619
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 20:31:10 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] fsldma: use PCI Read Multiple command
Date: Tue, 28 Apr 2009 09:31:08 +0800
Message-ID: <D7CCA83BB0796C49BC0BB53B6AB1208928CAB2@zch01exm21.fsl.freescale.net>
In-Reply-To: <ed82fe3e0904270731g2d2519a7mc12e4152c716c0a9@mail.gmail.com>
References: <20090424183517.GB23140@ovro.caltech.edu>
	<D7CCA83BB0796C49BC0BB53B6AB1208928CA1D@zch01exm21.fsl.freescale.net>
	<ed82fe3e0904270731g2d2519a7mc12e4152c716c0a9@mail.gmail.com>
From: "Liu Dave-R63238" <DaveLiu@freescale.com>
To: "Tabi Timur-B04825" <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org, Ira Snyder <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > You are assuming the PCI memory space is prefetchable( no=20
> > side effect) for DMA.
> > Is it possible that DMA is from non-prefetchable memory space?
>=20
> This should be a safe assumption for this driver.  Remember, this
> driver just does offload memcpy, from one region to another.  So the
> PCI memory that you are reading from should be just a buffer of data,
> and there should be side-effect of reading it.
>=20
> However, I would like to see a comment at the top of the file warning
> people that copying from PCI memory will result in prefetched reads.

How about FIFO RAM case?
