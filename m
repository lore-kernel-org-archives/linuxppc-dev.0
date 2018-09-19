Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42FxMN5KKlzDrJs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 09:46:08 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add PPC contacts for PCI core error handling
In-Reply-To: <20180912165846.GH118330@bhelgaas-glaptop.roam.corp.google.com>
References: <153677132617.23091.12307288405707171077.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180912165846.GH118330@bhelgaas-glaptop.roam.corp.google.com>
Date: Thu, 20 Sep 2018 09:46:07 +1000
Message-ID: <878t3xaw5c.fsf@concordia.ellerman.id.au>
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
> On Wed, Sep 12, 2018 at 11:55:26AM -0500, Bjorn Helgaas wrote:
>> From: Bjorn Helgaas <bhelgaas@google.com>
>> 
>> The original PCI error recovery functionality was for the powerpc-specific
>> IBM EEH feature.  PCIe subsequently added some similar features, including
>> AER and DPC, that can be used on any architecture.
>> 
>> We want the generic PCI core error handling support to work with all of
>> these features.  Driver error recovery callbacks should be independent of
>> which feature the platform provides.
>> 
>> Add the generic PCI core error recovery files to the powerpc EEH
>> MAINTAINERS entry so the powerpc folks will be copied on changes to the
>> generic PCI error handling strategy.
>
> I really want to make sure the powerpc folks are plugged into any PCI core
> error handling discussions.  Please let me know if there's a better way
> than this patch, or if there are other people who should be added.

Yeah this is a good option.

We powerpc folks also need to do a better job of keeping an eye on PCI
patches, I've asked more of us to subscribe to linux-pci.

cheers
