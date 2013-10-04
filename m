Return-Path: <agordeev@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 748032C009D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Oct 2013 15:12:02 +1000 (EST)
Date: Fri, 4 Oct 2013 07:13:24 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Ben Hutchings <bhutchings@solarflare.com>
Subject: Re: [PATCH RFC 06/77] PCI/MSI: Factor out pci_get_msi_cap() interface
Message-ID: <20131004051322.GA3577@dhcp-26-207.brq.redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <9c282c4ab92731c719d161d2db6fc54ce33891d9.1380703262.git.agordeev@redhat.com>
 <1380837174.3419.21.camel@bwh-desktop.uk.level5networks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380837174.3419.21.camel@bwh-desktop.uk.level5networks.com>
Cc: linux-mips@linux-mips.org, "VMware, Inc." <pv-drivers@vmware.com>,
 linux-nvme@lists.infradead.org, linux-ide@vger.kernel.org,
 linux-s390@vger.kernel.org, Andy King <acking@vmware.com>,
 linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, linux-pci@vger.kernel.org,
 iss_storagedev@hp.com, linux-driver@qlogic.com, Tejun Heo <tj@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Jon Mason <jon.mason@intel.com>,
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

On Thu, Oct 03, 2013 at 10:52:54PM +0100, Ben Hutchings wrote:
> On Wed, 2013-10-02 at 12:48 +0200, Alexander Gordeev wrote:
> >  #ifndef CONFIG_PCI_MSI
> > +static inline int pci_get_msi_cap(struct pci_dev *dev)
> > +{
> > +	return -1;
> [...]
> 
> Shouldn't this also return -EINVAL?

Yep, all inliners here are better to return -EINVAL.
Will do unless someone speaks out against.

> Ben.

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
