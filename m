Return-Path: <ruscur@russell.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429jGR2qX3zF3RM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 12:27:09 +1000 (AEST)
Message-ID: <94b8929d44af6dd965600b7d159458312d500582.camel@russell.cc>
Subject: Re: [PATCH] MAINTAINERS: Add PPC contacts for PCI core error handling
From: Russell Currey <ruscur@russell.cc>
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, sbobroff@linux.ibm.com
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-kernel@vger.kernel.org, oohall@gmail.com
In-Reply-To: <20180912165846.GH118330@bhelgaas-glaptop.roam.corp.google.com>
References: <153677132617.23091.12307288405707171077.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180912165846.GH118330@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 13 Sep 2018 12:26:55 +1000
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-09-12 at 11:58 -0500, Bjorn Helgaas wrote:
> On Wed, Sep 12, 2018 at 11:55:26AM -0500, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > The original PCI error recovery functionality was for the powerpc-specific
> > IBM EEH feature.  PCIe subsequently added some similar features, including
> > AER and DPC, that can be used on any architecture.
> > 
> > We want the generic PCI core error handling support to work with all of
> > these features.  Driver error recovery callbacks should be independent of
> > which feature the platform provides.
> > 
> > Add the generic PCI core error recovery files to the powerpc EEH
> > MAINTAINERS entry so the powerpc folks will be copied on changes to the
> > generic PCI error handling strategy.
> 
> I really want to make sure the powerpc folks are plugged into any PCI core
> error handling discussions.  Please let me know if there's a better way
> than this patch, or if there are other people who should be added.

I think this patch is definitely a good idea.

Alongside this (whether you want to include it in your patch or not, Bjorn),
Sam Bobroff should replace myself as maintainer.  He's been very active in fixing,
reworking and reviewing in EEH land and will probably do a better job of keeping
his finger on the pulse of the generic PCI error handling code than I did.

- Russell

> 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  MAINTAINERS |    4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 7e10ba65bfe4..d6699597fd89 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -11202,6 +11202,10 @@ PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
> >  M:	Russell Currey <ruscur@russell.cc>
> >  L:	linuxppc-dev@lists.ozlabs.org
> >  S:	Supported
> > +F:	Documentation/PCI/pci-error-recovery.txt
> > +F:	drivers/pci/pcie/aer.c
> > +F:	drivers/pci/pcie/dpc.c
> > +F:	drivers/pci/pcie/err.c
> >  F:	Documentation/powerpc/eeh-pci-error-recovery.txt
> >  F:	arch/powerpc/kernel/eeh*.c
> >  F:	arch/powerpc/platforms/*/eeh*.c
> > 
