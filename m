Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 53D74DDEFA
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 23:45:00 +1000 (EST)
Message-ID: <49F707FA.7070603@freescale.com>
Date: Tue, 28 Apr 2009 08:43:22 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: David Hawkins <dwh@ovro.caltech.edu>
Subject: Re: [PATCH] fsldma: use PCI Read Multiple command
References: <20090424183517.GB23140@ovro.caltech.edu>	<D7CCA83BB0796C49BC0BB53B6AB1208928CA1D@zch01exm21.fsl.freescale.net>	<ed82fe3e0904270731g2d2519a7mc12e4152c716c0a9@mail.gmail.com>
	<D7CCA83BB0796C49BC0BB53B6AB1208928CAB2@zch01exm21.fsl.freescale.net>
	<49F65DBA.2090702@ovro.caltech.edu>
In-Reply-To: <49F65DBA.2090702@ovro.caltech.edu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Dan Williams <dan.j.williams@intel.com>,
	Liu Dave-R63238 <DaveLiu@freescale.com>,
	linux-kernel@vger.kernel.org, Ira Snyder <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Hawkins wrote:
>> How about FIFO RAM case?
> 
> If the FIFO has a fixed address, then according to
> the user guide, the DMA controller won't generate
> a burst transaction to it.
> 
> We can try confirming this if you'd like.

Like I said earlier, this driver does not support copying data to/from a
single register address.  It's just a off-loaded memcpy.  So we don't
need to worry about what happens to a fixed address.

-- 
Timur Tabi
Linux kernel developer at Freescale
