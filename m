Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ylvmn1Kd3zDr77
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 05:03:36 +1100 (AEDT)
Date: Mon, 27 Nov 2017 12:03:32 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] powerpc/pci: convert to use for_each_pci_bridge()
 helper
Message-ID: <20171127180332.GA11228@bhelgaas-glaptop.roam.corp.google.com>
References: <20171110175230.82522-1-andriy.shevchenko@linux.intel.com>
 <20171122201259.GA21158@bhelgaas-glaptop.roam.corp.google.com>
 <87zi7d17ql.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87zi7d17ql.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 23, 2017 at 11:48:18PM +1100, Michael Ellerman wrote:
> Bjorn Helgaas <helgaas@kernel.org> writes:
> 
> > On Fri, Nov 10, 2017 at 07:52:29PM +0200, Andy Shevchenko wrote:
> >> ...which makes code slightly cleaner.
> >> 
> >> Requires: d43f59ce6c50 ("PCI: Add for_each_pci_bridge() helper")
> >
> > Requires: 24a0c654d7d6 ("PCI: Add for_each_pci_bridge() helper")
> >
> > (My fault, I rebased that commit before sending it to Linus.)
> >
> >> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> >
> > These don't depend on anything in the PCI core, so they could go
> > either via my tree or the powerpc tree.  Since you acked this,
> > Michael, I corrected the SHA1 above and put these both on my pci/misc
> > branch.
> 
> Thanks. That's aiming for 4.16 I assume?

Right.
