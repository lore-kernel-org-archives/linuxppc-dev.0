Return-Path: <Ian.Campbell@eu.citrix.com>
Received: from SMTP.CITRIX.COM (smtp.citrix.com [66.165.176.89])
	by ozlabs.org (Postfix) with ESMTP id 5180FDDD0C
	for <linuxppc-dev@ozlabs.org>; Sat, 30 May 2009 23:03:50 +1000 (EST)
Subject: Re: [PATCH 6/9] swiotlb: use dma_to_phys and phys_to_dma
From: Ian Campbell <Ian.Campbell@citrix.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
In-Reply-To: <4A204EFC.501@goop.org>
References: <1243586643-5554-1-git-send-email-ian.campbell@citrix.com>
	<1243586643-5554-7-git-send-email-ian.campbell@citrix.com>
	<4A204EFC.501@goop.org>
Content-Type: text/plain
Date: Sat, 30 May 2009 14:02:58 +0100
Message-ID: <1243688578.4399.67.camel@localhost.localdomain>
MIME-Version: 1.0
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
	Olaf Kirch <okir@suse.de>, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2009-05-29 at 14:09 -0700, Jeremy Fitzhardinge wrote:
> Ian Campbell wrote:
> >  void * __weak swiotlb_bus_to_virt(struct device *hwdev, dma_addr_t address)
> >   
> 
> Does this need to be weak too?

It's was wanted by PowerPC to support highmem, that's what patch 8/9
tries to address in an arch-independent way.

Ian.
