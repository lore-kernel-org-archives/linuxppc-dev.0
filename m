Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5067C689FD
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Feb 2006 07:33:40 +1100 (EST)
Message-ID: <43E11B95.9030902@ovro.caltech.edu>
Date: Wed, 01 Feb 2006 12:35:33 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
Subject: Re: Yosemite/440EP why are readl()/ioread32() setup to
	readlittle-endian?
References: <35786B99AB3FDC45A8215724617919736D921B@gbrwgceumf01.eu.xerox.net>
In-Reply-To: <35786B99AB3FDC45A8215724617919736D921B@gbrwgceumf01.eu.xerox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> I said this without looking up the example you cited.
> I agree now, the example is incorrect; and yes, file a bug
> report at oreilly!

Ok, I will.

> I think, from memory, that elsewhere in the book Rubini does
> say that readl()... are for the PCI bus, but cross-arch issues
> are only addressed in certain sections.

I didn't find anything that specifically mentioned their
use was for the PCI bus only. The endianness swapping
features of the pci_config_xxx functions are clearly
stated, but not the readl/writel. And of course the
example I refer to clearly uses those functions on the
PCI bus incorrectly.

But its still a great book.

> I always find out exactly what these macros do on the arch
> I am using, then I know where I stand. I find LXR (Google it if
> you don't know it) good for browsing the source of vanilla
> kernels. After finding out how and where it is done, I then
> double check the relevant files of the actual kernel I am using.
> 
> ppc implementations of readl, writel, cpu_to_le32 use the byte-
> reversed load/store word instructions.

Ahh, very good advice. I think I read about LXR in one of
Freescale's app notes on porting Linux. I'll go take a look
on Google.

Thanks
Dave
