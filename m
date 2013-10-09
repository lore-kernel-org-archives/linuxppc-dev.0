Return-Path: <htejun@gmail.com>
Received: from mail-yh0-x22c.google.com (mail-yh0-x22c.google.com
 [IPv6:2607:f8b0:4002:c01::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7B6952C03BC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Oct 2013 02:58:01 +1100 (EST)
Received: by mail-yh0-f44.google.com with SMTP id f10so209859yha.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Oct 2013 08:57:58 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 9 Oct 2013 11:57:52 -0400
From: Tejun Heo <tj@kernel.org>
To: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
Message-ID: <20131009155752.GE22495@htj.dyndns.org>
References: <cover.1380703262.git.agordeev@redhat.com>
 <20131007182117.GC27396@htj.dyndns.org>
 <20131008090716.GA10561@dhcp-26-207.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131008090716.GA10561@dhcp-26-207.brq.redhat.com>
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

On Tue, Oct 08, 2013 at 11:07:16AM +0200, Alexander Gordeev wrote:
> Multipe MSIs is just a handful of drivers, really. MSI-X impact still

Yes, so it's pretty nice to try out things there before going full-on.

> will be huge. But if we opt a different name for the new pci_enable_msix()
> then we could first update pci/msi, then drivers (in few stages possibly)
> and finally remove the old implementation.

Yes, that probably should be the steps to follow eventually.  My point
was that you don't have to submit patches for all 7x conversions for
an RFC round.  Scanning them and seeing what would be necessary
definitely is a good idea but just giving summary of the full
conversion with several examples should be good enough before settling
on the way forward, which should be easier for all involved.

Thanks a lot for your effort!

-- 
tejun
