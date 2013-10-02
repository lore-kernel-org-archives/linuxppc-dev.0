Return-Path: <greg@kroah.com>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 614A92C03BD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 04:19:13 +1000 (EST)
Date: Wed, 2 Oct 2013 11:17:49 -0700
From: Greg KH <greg@kroah.com>
To: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH RFC 04/77] PCI/MSI/s390: Remove superfluous check of MSI
 type
Message-ID: <20131002181749.GA6942@kroah.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <bae65aa3e30dfd23bd5ed47add7310cfbb96243a.1380703262.git.agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bae65aa3e30dfd23bd5ed47add7310cfbb96243a.1380703262.git.agordeev@redhat.com>
Cc: linux-mips@linux-mips.org, "VMware, Inc." <pv-drivers@vmware.com>,
 linux-nvme@lists.infradead.org, linux-ide@vger.kernel.org,
 stable@vger.kernel.org, linux-s390@vger.kernel.org,
 Andy King <acking@vmware.com>, linux-scsi@vger.kernel.org,
 linux-rdma@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 linux-pci@vger.kernel.org, iss_storagedev@hp.com, linux-driver@qlogic.com,
 Tejun Heo <tj@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>, Jon Mason <jon.mason@intel.com>,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, e1000-devel@lists.sourceforge.net,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 02, 2013 at 12:48:20PM +0200, Alexander Gordeev wrote:
> arch_setup_msi_irqs() hook can only be called from the generic
> MSI code which ensures correct MSI type parameter.
> 
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> ---
>  arch/s390/pci/pci.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)

I have no idea why you sent the stable@ alias so many patches, all in
the incorrect form for them to be ever accepted in the stable kernel
releases.  Please read Documentation/stable_kernel_rules.txt for how to
do this properly.

greg k-h
