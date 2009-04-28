Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id C398ADDDA0
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 11:37:05 +1000 (EST)
Message-ID: <49F65DBA.2090702@ovro.caltech.edu>
Date: Mon, 27 Apr 2009 18:36:58 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Liu Dave-R63238 <DaveLiu@freescale.com>
Subject: Re: [PATCH] fsldma: use PCI Read Multiple command
References: <20090424183517.GB23140@ovro.caltech.edu>	<D7CCA83BB0796C49BC0BB53B6AB1208928CA1D@zch01exm21.fsl.freescale.net>	<ed82fe3e0904270731g2d2519a7mc12e4152c716c0a9@mail.gmail.com>
	<D7CCA83BB0796C49BC0BB53B6AB1208928CAB2@zch01exm21.fsl.freescale.net>
In-Reply-To: <D7CCA83BB0796C49BC0BB53B6AB1208928CAB2@zch01exm21.fsl.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Dan Williams <dan.j.williams@intel.com>,
	Ira Snyder <iws@ovro.caltech.edu>, Tabi Timur-B04825 <timur@freescale.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> How about FIFO RAM case?

If the FIFO has a fixed address, then according to
the user guide, the DMA controller won't generate
a burst transaction to it.

We can try confirming this if you'd like.

Cheers,
Dave
