Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 089CADDE11
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 06:47:09 +1000 (EST)
Message-ID: <49F619C4.20100@freescale.com>
Date: Mon, 27 Apr 2009 15:47:00 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Ira Snyder <iws@ovro.caltech.edu>
Subject: Re: [PATCH] fsldma: use PCI Read Multiple command
References: <20090424183517.GB23140@ovro.caltech.edu>
	<D7CCA83BB0796C49BC0BB53B6AB1208928CA1D@zch01exm21.fsl.freescale.net>
	<ed82fe3e0904270731g2d2519a7mc12e4152c716c0a9@mail.gmail.com>
	<49F608B7.9080409@ovro.caltech.edu>
	<49F60A3A.4060402@freescale.com>
	<49F61416.8040501@ovro.caltech.edu> <49F614FC.70000@freescale.com>
	<20090427204213.GA4960@ovro.caltech.edu>
In-Reply-To: <20090427204213.GA4960@ovro.caltech.edu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Hawkins <dwh@ovro.caltech.edu>,
	Liu Dave-R63238 <DaveLiu@freescale.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Dan Williams <dan.j.williams@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Adding Kumar to the CC: list, since he might pick up the patch.

Ira Snyder wrote:

> From 73e42fa58c93de8d4d429ba8e069b60c42037b58 Mon Sep 17 00:00:00 2001
> From: Ira W. Snyder <iws@ovro.caltech.edu>
> Date: Thu, 23 Apr 2009 16:17:54 -0700
> Subject: [PATCH] fsldma: use PCI Read Multiple command
> 
> By default, the Freescale 83xx DMA controller uses the PCI Read Line
> command when reading data over the PCI bus. Setting the controller to use
> the PCI Read Multiple command instead allows the controller to read much
> larger bursts of data, which provides a drastic speed increase.
> 
> The slowdown due to using PCI Read Line was only observed when a PCI-to-PCI
> bridge was between the devices trying to communicate.
> 
> A simple test driver showed an increase from 4MB/sec to 116MB/sec when
> performing DMA over the PCI bus. Using DMA to transfer between blocks of
> local SDRAM showed no change in performance with this patch. The dmatest
> driver was also used to verify the correctness of the transfers, and showed
> no errors.
> 
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>

Acked-by: Timur Tabi <timur@freescale.com>

-- 
Timur Tabi
Linux kernel developer at Freescale
