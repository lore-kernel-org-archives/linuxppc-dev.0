Return-Path: <htejun@gmail.com>
Received: from mail-qe0-x233.google.com (mail-qe0-x233.google.com
 [IPv6:2607:f8b0:400d:c02::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 70D1F2C0127
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Oct 2013 02:46:16 +1100 (EST)
Received: by mail-qe0-f51.google.com with SMTP id q19so741248qeb.24
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Oct 2013 08:46:12 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 9 Oct 2013 11:46:06 -0400
From: Tejun Heo <tj@kernel.org>
To: Ben Hutchings <bhutchings@solarflare.com>
Subject: Re: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
Message-ID: <20131009154606.GC22495@htj.dyndns.org>
References: <cover.1380703262.git.agordeev@redhat.com>
 <1380840585.3419.50.camel@bwh-desktop.uk.level5networks.com>
 <20131004082920.GA4536@dhcp-26-207.brq.redhat.com>
 <1380922156.3214.49.camel@bwh-desktop.uk.level5networks.com>
 <20131005142054.GA11270@dhcp-26-207.brq.redhat.com>
 <1381009586.645.141.camel@pasglop>
 <20131006060243.GB28142@dhcp-26-207.brq.redhat.com>
 <1381040386.645.143.camel@pasglop>
 <20131006071027.GA29143@dhcp-26-207.brq.redhat.com>
 <1381178881.1536.28.camel@bwh-desktop.uk.level5networks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381178881.1536.28.camel@bwh-desktop.uk.level5networks.com>
Cc: linux-mips@linux-mips.org, "VMware, Inc." <pv-drivers@vmware.com>,
 linux-nvme@lists.infradead.org, linux-ide@vger.kernel.org,
 linux-s390@vger.kernel.org, Andy King <acking@vmware.com>,
 linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org, x86@kernel.org,
 Alexander Gordeev <agordeev@redhat.com>, linux-pci@vger.kernel.org,
 iss_storagedev@hp.com, linux-driver@qlogic.com,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Jon Mason <jon.mason@intel.com>, Ingo Molnar <mingo@redhat.com>,
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

On Mon, Oct 07, 2013 at 09:48:01PM +0100, Ben Hutchings wrote:
> > There is one major flaw in min-max approach - the generic MSI layer
> > will have to take decisions on exact number of MSIs to request, not
> > device drivers.
> [...
> 
> No, the min-max functions should be implemented using the same loop that
> drivers are expected to use now.

Wheee... earlier in the thread I thought you guys were referring to
yourselves in the third person and was getting a bit worried. :)

-- 
tejun
