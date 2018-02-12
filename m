Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zfs9q113TzF0js
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 14:49:35 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bjorn Helgaas <helgaas@kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH kernel v3] powerpc/pci: Fix broken INTx configuration via
 OF
In-Reply-To: <20180210205118.GG206223@bhelgaas-glaptop.roam.corp.google.com>
References: <20180209062358.33457-1-aik@ozlabs.ru>
 <20180209180741.GB206223@bhelgaas-glaptop.roam.corp.google.com>
 <20180210205118.GG206223@bhelgaas-glaptop.roam.corp.google.com>
Date: Mon, 12 Feb 2018 14:49:32 +1100
Message-ID: <87k1vix3xv.fsf@concordia.ellerman.id.au>
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

> On Fri, Feb 09, 2018 at 12:07:41PM -0600, Bjorn Helgaas wrote:
>> On Fri, Feb 09, 2018 at 05:23:58PM +1100, Alexey Kardashevskiy wrote:
>> > Commit 59f47eff03a0 ("powerpc/pci: Use of_irq_parse_and_map_pci() helper")
>> > replaced of_irq_parse_pci() + irq_create_of_mapping() with
>> > of_irq_parse_and_map_pci() but this change lost virq returned by
>> > irq_create_of_mapping() so virq remained zero causing INTx
>> > misconfiguration.
>> > 
>> > This fixes pci_read_irq_line() not to loose a virq returned by
>> > of_irq_parse_and_map_pci().
>> 
>> s/not to loose a/to not lose the/
>> 
>> > Fixes: 59f47eff03a0 "powerpc/pci: Use of_irq_parse_and_map_pci() helper"
>> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> 
>> I'm fine with this version.
>> 
>> Since you started applying a previous version, Michael, I'll assume
>> you will handle this unless you tell me otherwise.  One way or another
>> it would be good to get this in before -rc1.
>
> I went ahead and applied this and asked Linus to pull it.

Thanks.

cheers
