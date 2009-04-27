Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DDCCBDDEF0
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 06:50:05 +1000 (EST)
Message-ID: <49F61A77.4060404@freescale.com>
Date: Mon, 27 Apr 2009 15:49:59 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] fsldma: use PCI Read Multiple command
References: <20090424183517.GB23140@ovro.caltech.edu>
	<D7CCA83BB0796C49BC0BB53B6AB1208928CA1D@zch01exm21.fsl.freescale.net>
	<ed82fe3e0904270731g2d2519a7mc12e4152c716c0a9@mail.gmail.com>
	<49F608B7.9080409@ovro.caltech.edu>
	<49F60A3A.4060402@freescale.com>
	<49F60BF8.8040404@ovro.caltech.edu> <49F60FE1.90707@freescale.com>
	<20090427204752.GA22406@ld0162-tx32.am.freescale.net>
In-Reply-To: <20090427204752.GA22406@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Hawkins <dwh@ovro.caltech.edu>, Ira Snyder <iws@ovro.caltech.edu>,
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

Scott Wood wrote:

> I thought the driver only used the bit if the device tree indicated it
> was an 83xx-era DMA controller?

I just wanted to make sure it didn't do anything weird.  It was the only
test I could think of that didn't involve PCI.

> That said, the bits are documented as specifically for PCI, so it would
> be surprising if it had any effect elsewhere.

Surely you wouldn't really be surprised by incorrect documentation of
our parts. :-)

-- 
Timur Tabi
Linux kernel developer at Freescale
