Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5F0CEDE01D
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 15:07:17 +1100 (EST)
Date: Thu, 11 Dec 2008 20:07:06 -0800 (PST)
From: Trent Piepho <tpiepho@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: How to support 3GB pci address?
In-Reply-To: <41706FC0-B740-42C0-BA2B-B9E4B5839477@kernel.crashing.org>
Message-ID: <Pine.LNX.4.64.0812111957470.28806@t2.domain.actdsltmp>
References: <200812112004118902765@gmail.com>
	<41706FC0-B740-42C0-BA2B-B9E4B5839477@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	"maillist.kernel" <maillist.kernel@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 11 Dec 2008, Kumar Gala wrote:
> On Dec 11, 2008, at 6:04 AM, maillist.kernel wrote:
>> In the system, the total PCI address needed is about 3GB, so I want to know 
>> how to support it in linux. mpc8548 has 36-bit real address, and can 
>> support 32GB PCIE address space, but in linux, there is only 1GB kernel 
>> space, how to map the 3GB pci address to kernel? Is the  36-bit real 
>> address only used to support large memory(>4GB) for muti-threads?
>
> The 36-bit support is current (in tree) in complete.  Work is in progress to 
> add swiotlb support to PPC which will generically enable what you want to 
> accomplish.

Don't the ATMU windows in the pcie controller serve as a IOMMU, making swiotlb
unnecessary and wasteful?
