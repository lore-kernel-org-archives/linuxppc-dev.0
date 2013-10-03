Return-Path: <jackm@dev.mellanox.co.il>
Received: from mail-ea0-f177.google.com (mail-ea0-f177.google.com
 [209.85.215.177])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 04F272C00B8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 18:39:38 +1000 (EST)
Received: by mail-ea0-f177.google.com with SMTP id f15so902135eak.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Oct 2013 01:39:34 -0700 (PDT)
Date: Thu, 3 Oct 2013 11:39:32 +0300
From: Jack Morgenstein <jackm@dev.mellanox.co.il>
To: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH RFC 46/77] mlx4: Update MSI/MSI-X interrupts enablement
 code
Message-ID: <20131003113932.065b9b63@jpm-OptiPlex-GX620>
In-Reply-To: <b0a9f6f455aa03b7769e6d9cc2e7fdbc06732b2f.1380703263.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <b0a9f6f455aa03b7769e6d9cc2e7fdbc06732b2f.1380703263.git.agordeev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-mips@linux-mips.org, "VMware, Inc." <pv-drivers@vmware.com>,
 linux-nvme@lists.infradead.org, linux-ide@vger.kernel.org, eli@mellanox.com,
 linux-s390@vger.kernel.org, Andy King <acking@vmware.com>,
 linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, linux-pci@vger.kernel.org,
 iss_storagedev@hp.com, linux-driver@qlogic.com, Tejun Heo <tj@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Jon Mason <jon.mason@intel.com>, ogerlitz@mellanox.com,
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

On Wed,  2 Oct 2013 12:49:02 +0200
Alexander Gordeev <agordeev@redhat.com> wrote:

> As result of recent re-design of the MSI/MSI-X interrupts enabling
> pattern this driver has to be updated to use the new technique to
> obtain a optimal number of MSI/MSI-X interrupts required.
> 
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>

New review -- ACK (i.e., patch is OK), subject to acceptance of patches
05 and 07 of this patch set.

I sent my previous review (NACK) when I was not yet aware that
changes proposed were due to the two earlier patches (mentioned above)
in the current patch set.

The change log here should actually read something like the following:

As a result of changes to the MSI/MSI_X enabling procedures, this driver
must be modified in order to preserve its current msi/msi_x enablement
logic.

-Jack
