Return-Path: <htejun@gmail.com>
Received: from mail-gg0-f179.google.com (mail-gg0-f179.google.com
 [209.85.161.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EC04D2C016B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 05:11:20 +1100 (EST)
Received: by mail-gg0-f179.google.com with SMTP id q1so1186583gge.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Oct 2013 11:10:47 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 7 Oct 2013 14:10:43 -0400
From: Tejun Heo <tj@kernel.org>
To: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH RFC 05/77] PCI/MSI: Convert pci_msix_table_size() to a
 public interface
Message-ID: <20131007181043.GA27396@htj.dyndns.org>
References: <cover.1380703262.git.agordeev@redhat.com>
 <e8b51bd48c24d0fc4ee8adea5c138c9bf84191e9.1380703262.git.agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e8b51bd48c24d0fc4ee8adea5c138c9bf84191e9.1380703262.git.agordeev@redhat.com>
Cc: linux-mips@linux-mips.org, "VMware, Inc." <pv-drivers@vmware.com>,
 linux-nvme@lists.infradead.org, linux-ide@vger.kernel.org,
 linux-s390@vger.kernel.org, Andy King <acking@vmware.com>,
 linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, linux-pci@vger.kernel.org,
 iss_storagedev@hp.com, linux-driver@qlogic.com,
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

Hello,

On Wed, Oct 02, 2013 at 12:48:21PM +0200, Alexander Gordeev wrote:
> Make pci_msix_table_size() to return a error code if the device
> does not support MSI-X. This update is needed to facilitate a
> forthcoming re-design MSI/MSI-X interrupts enabling pattern.
> 
> Device drivers will use this interface to obtain maximum number
> of MSI-X interrupts the device supports and use that value in
> the following call to pci_enable_msix() interface.
> 
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>

Hmmm... I probably missed something but why is this necessary?  To
discern between -EINVAL and -ENOSPC?  If so, does that really matter?

Thanks.

-- 
tejun
