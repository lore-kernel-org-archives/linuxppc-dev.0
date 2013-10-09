Return-Path: <kernel@start.ca>
Received: from mouse.start.ca (mouse.start.ca [64.140.120.56])
 by ozlabs.org (Postfix) with ESMTP id 8FF8C2C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Oct 2013 12:56:26 +1100 (EST)
Message-ID: <5254B78E.3020009@start.ca>
Date: Tue, 08 Oct 2013 21:55:26 -0400
From: Mark Lord <kernel@start.ca>
MIME-Version: 1.0
To: Alexander Gordeev <agordeev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
References: <cover.1380703262.git.agordeev@redhat.com>
In-Reply-To: <cover.1380703262.git.agordeev@redhat.com>
Content-Type: text/plain; charset=UTF-8
Cc: linux-mips@linux-mips.org, VMware@dhcp-26-207.brq.redhat.com,
 "Inc." <pv-drivers@vmware.com>, linux-nvme@lists.infradead.org,
 linux-ide@vger.kernel.org, linux-s390@vger.kernel.org,
 Andy King <acking@vmware.com>, linux-scsi@vger.kernel.org,
 linux-rdma@vger.kernel.org, x86@kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 linux-pci@vger.kernel.org, iss_storagedev@hp.com, linux-driver@qlogic.com,
 Tejun Heo <tj@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>, Jon Mason <jon.mason@intel.com>,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 netdev@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 e1000-devel@lists.sourceforge.net, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linux390@de.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 13-10-02 06:29 AM, Alexander Gordeev wrote:
..
> This update converts pci_enable_msix() and pci_enable_msi_block()
> interfaces to canonical kernel functions and makes them return a
> error code in case of failure or 0 in case of success.

Rather than silently break dozens of drivers in mysterious ways,
please invent new function names for the replacements to the
existing pci_enable_msix() and pci_enable_msi_block() functions.

That way, both in-tree and out-of-tree drivers will notice the API change,
rather than having it go unseen and just failing for unknown reasons.

Thanks.
