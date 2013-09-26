Return-Path: <agordeev@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 8A2F22C0091
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 22:11:23 +1000 (EST)
Date: Thu, 26 Sep 2013 14:13:25 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH v2 2/6] PCI/MSI: Factor out pci_get_msi_cap() interface
Message-ID: <20130926121325.GC16774@dhcp-26-207.brq.redhat.com>
References: <20130918165045.GB2353@dhcp-26-207.brq.redhat.com>
 <20130920082458.GA10507@dhcp-26-207.brq.redhat.com>
 <20130920122736.GD7630@mtj.dyndns.org>
 <20130925180220.GB26273@google.com>
 <20130925205804.GA21737@dhcp-26-207.brq.redhat.com>
 <20130925210016.GA8926@htj.dyndns.org>
 <20130926074646.GA16774@dhcp-26-207.brq.redhat.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B735D@saturn3.aculab.com>
 <20130926104548.GB16774@dhcp-26-207.brq.redhat.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B7360@saturn3.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B7360@saturn3.aculab.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 Joerg Roedel <joro@8bytes.org>, x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, Jan Beulich <JBeulich@suse.com>,
 Tejun Heo <tj@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 26, 2013 at 12:34:36PM +0100, David Laight wrote:
> I was thinking that the first call would be done during driver probe
> (assuming such a time exists) so that the subsystem could determine
> how many interrupts all the drivers would like, so it can then
> hand out a smaller number to some of the early drivers in order
> to have some left to satisfy the minimum requirement of later
> ones.
> 
> So all it would do is sum the requirements of all the drivers.

It is already implemented - please see commit 448e2ca ("powerpc/pseries:
Implement a quota system for MSIs")

All other archs do not have MSI vector space limitations.

> 	David

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
