Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 220C6DDE19
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 10:41:26 +1100 (EST)
Message-ID: <47B22E98.8040900@freescale.com>
Date: Tue, 12 Feb 2008 17:41:12 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>, Arnd Bergmann <arnd@arndb.de>,
	Timur Tabi <timur@freescale.com>, linuxppc-dev@ozlabs.org
Subject: Re: Could the DTS experts look at this?
References: <47ACE630.8090101@pikatech.com>
	<20080211235409.GB18348@localhost.localdomain>
	<20080211235652.GC18348@localhost.localdomain>
	<200802120121.45349.arnd@arndb.de>
	<20080212003633.GF18348@localhost.localdomain>
	<20080212185106.GA4042@loki.buserror.net>
	<20080212231702.GB21230@localhost.localdomain>
In-Reply-To: <20080212231702.GB21230@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:

> I'm not sure I'm entirely happy about storing the fragments under a
> special node - but certainly u-boot could do that if it wants.  What
> would certainly be ok is to store various fragments as separate blobs
> and fold them together as necessary.  Which reminds me, I meant to
> implement a "graft" function in libfdt.

Most likely, U-Boot would strip out the special node after processing it.  The 
idea is for the boot loader to customize the device tree based before sending it 
to the kernel.

-- 
Timur Tabi
Linux kernel developer at Freescale
