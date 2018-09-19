Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42FvL76G28zDrWR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 08:14:55 +1000 (AEST)
Date: Wed, 19 Sep 2018 17:14:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Russell Currey <ruscur@russell.cc>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 oohall@gmail.com, sbobroff@linux.ibm.com
Subject: Re: [PATCH] MAINTAINERS: Add PPC contacts for PCI core error handling
Message-ID: <20180919221452.GC261184@bhelgaas-glaptop.roam.corp.google.com>
References: <153677132617.23091.12307288405707171077.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180918215854.GH13616@bhelgaas-glaptop.roam.corp.google.com>
 <1020abbb3d8a8f121d25da7327e296cfa1aaa698.camel@russell.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1020abbb3d8a8f121d25da7327e296cfa1aaa698.camel@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 19, 2018 at 11:49:26AM +1000, Russell Currey wrote:
> On Tue, 2018-09-18 at 16:58 -0500, Bjorn Helgaas wrote:
> > On Wed, Sep 12, 2018 at 11:55:26AM -0500, Bjorn Helgaas wrote:
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > 
> > > The original PCI error recovery functionality was for the powerpc-specific
> > > IBM EEH feature.  PCIe subsequently added some similar features, including
> > > AER and DPC, that can be used on any architecture.
> > > 
> > > We want the generic PCI core error handling support to work with all of
> > > these features.  Driver error recovery callbacks should be independent of
> > > which feature the platform provides.
> > > 
> > > Add the generic PCI core error recovery files to the powerpc EEH
> > > MAINTAINERS entry so the powerpc folks will be copied on changes to the
> > > generic PCI error handling strategy.
> > > 
> > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > I applied the following to for-linus for v4.19.  Russell, if you want
> > to be removed, let me know and I'll do that.
> 
> Oliver's email address for kernel stuff is oohall@gmail.com, I think benh has been
> CCing his IBM address.  But other than that,
> 
> Acked-by: Russell Currey <ruscur@russell.cc>

I updated Oliver's email address and added your ack, thanks!
