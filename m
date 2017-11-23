Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjJyr1sf4zDrbP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Nov 2017 23:48:20 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bjorn Helgaas <helgaas@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] powerpc/pci: convert to use for_each_pci_bridge()
 helper
In-Reply-To: <20171122201259.GA21158@bhelgaas-glaptop.roam.corp.google.com>
References: <20171110175230.82522-1-andriy.shevchenko@linux.intel.com>
 <20171122201259.GA21158@bhelgaas-glaptop.roam.corp.google.com>
Date: Thu, 23 Nov 2017 23:48:18 +1100
Message-ID: <87zi7d17ql.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bjorn Helgaas <helgaas@kernel.org> writes:

> On Fri, Nov 10, 2017 at 07:52:29PM +0200, Andy Shevchenko wrote:
>> ...which makes code slightly cleaner.
>> 
>> Requires: d43f59ce6c50 ("PCI: Add for_each_pci_bridge() helper")
>
> Requires: 24a0c654d7d6 ("PCI: Add for_each_pci_bridge() helper")
>
> (My fault, I rebased that commit before sending it to Linus.)
>
>> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
>
> These don't depend on anything in the PCI core, so they could go
> either via my tree or the powerpc tree.  Since you acked this,
> Michael, I corrected the SHA1 above and put these both on my pci/misc
> branch.

Thanks. That's aiming for 4.16 I assume?

cheers
