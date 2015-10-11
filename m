Return-Path: <lkp@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by lists.ozlabs.org (Postfix) with ESMTP id 5A8C81A0617
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 01:22:59 +1100 (AEDT)
Date: Sun, 11 Oct 2015 22:22:35 +0800
From: Fengguang Wu <lkp@intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Keith Busch <keith.busch@intel.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@infradead.org>,
 Paul Mackerras <paulus@samba.org>, kbuild-all@01.org,
 Matthew Wilcox <willy@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [kbuild-all] [PATCH 4/5 v2] pseries/iommu: implement DDW-aware
 dma_get_page_shift
Message-ID: <20151011142235.GC17528@wfg-t540p.sh.intel.com>
References: <201510030421.d9fvrbXU%fengguang.wu@intel.com>
 <1444102746.16909.4.camel@ellerman.id.au>
 <20151007135602.GA17377@wfg-t540p.sh.intel.com>
 <1444263119.31685.4.camel@ellerman.id.au>
 <20151008010603.GA24198@wfg-t540p.sh.intel.com>
 <20151008011609.GA25163@wfg-t540p.sh.intel.com>
 <1444277187.9940.7.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444277187.9940.7.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

> > > > How did the robot decide to build this series in the first place? Does it build
> > > > everything sent to one of the lists on CC?
> > > 
> > > Yes, currently the following mailing lists are subscribed.  Patches
> > > sent to them will be tested if they can be git-am to RC or linux-next
> > > kernels:
> > > 
> > > kvm
> > > linux-acpi
> > > linux-bluetooth
> > > linux-btrfs
> > > linux-embedded
> > > linux-ext4
> > > linux-fsdevel
> > > linux-media
> > > linux-mmc
> > > linux-nfs
> > > linux-omap
> > > linux-pci
> > > linux-pm
> > > linux-raid
> > > linux-rdma
> > > linux-scsi
> > > linux-usb
> > > linux-wireless
> > > netdev
> > > netfilter-devel
> > > linux-mm
> > > driverdev-devel
> > > intel-gfx
> > 
> > And of course linux-kernel. More lists could be added in future.
> 
> So do you mind adding linuxppc-dev@lists.ozlabs.org ? :)
> 
> It's pretty low traffic compared to lkml.

Sure, I'm subscribing to it. :)

Thanks,
Fengguang
