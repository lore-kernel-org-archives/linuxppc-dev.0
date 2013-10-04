Return-Path: <agordeev@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 533352C00E4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Oct 2013 19:19:41 +1000 (EST)
Date: Fri, 4 Oct 2013 11:21:09 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
Message-ID: <20131004092108.GB4536@dhcp-26-207.brq.redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <1380840585.3419.50.camel@bwh-desktop.uk.level5networks.com>
 <20131004082920.GA4536@dhcp-26-207.brq.redhat.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B7371@saturn3.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B7371@saturn3.aculab.com>
Cc: linux-mips@linux-mips.org, "VMware, Inc." <pv-drivers@vmware.com>,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-ide@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linux-s390@vger.kernel.org, Andy King <acking@vmware.com>,
 linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, iss_storagedev@hp.com,
 linuxppc-dev@lists.ozlabs.org, linux-driver@qlogic.com,
 Ben Hutchings <bhutchings@solarflare.com>,
 Dan Williams <dan.j.williams@intel.com>, Jon Mason <jon.mason@intel.com>,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, e1000-devel@lists.sourceforge.net,
 Tejun Heo <tj@kernel.org>, linux390@de.ibm.com,
 Bjorn Helgaas <bhelgaas@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 04, 2013 at 09:31:49AM +0100, David Laight wrote:
> > Mmmm.. I am not sure I am getting it. Could you please rephrase?
> 
> One possibility is for drivers than can use a lot of interrupts to
> request a minimum number initially and then request the additional
> ones much later on.
> That would make it less likely that none will be available for
> devices/drivers that need them but are initialised later.

It sounds as a whole new topic for me. Isn't it?

Anyway, what prevents the above from being done with pci_enable_msix(nvec1) -
pci_disable_msix() - pci_enable_msix(nvec2) where nvec1 < nvec2?

> 	David

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
