Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id ABEB7DDDEA
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 21:40:04 +1100 (EST)
Message-ID: <47A1A137.8020605@scram.de>
Date: Thu, 31 Jan 2008 11:21:43 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC] [POWERPC] bootwrapper: build multiple cuImages
References: <20080131003347.5779.96112.stgit@trillian.secretlab.ca>
In-Reply-To: <20080131003347.5779.96112.stgit@trillian.secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Grant,

> Currently, the kernel uses CONFIG_DEVICE_TREE to wrap a kernel image
> with a fdt blob which means for any given configuration only one dts
> file can be selected and so support for only one board can be built
> 
> This patch moves the selection of the default .dts file out of the kernel
> config and into the bootwrapper makefile.  The makefile chooses which
> images to build based on the kernel config and the dts source file
> name is taken directly from the image name.  For example "cuImage.ebony"
> will use "ebony.dts" as the device tree source file.

Cool stuff. This should be the last step to enable multiplatform builds on
8xx etc. as Arndt asked a few days ago ;)

Thanks,
Jochen
