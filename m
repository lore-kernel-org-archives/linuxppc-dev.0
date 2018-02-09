Return-Path: <aik@ozlabs.ru>
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com
 [IPv6:2607:f8b0:4001:c0b::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zd20X0P1FzF170
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Feb 2018 15:20:11 +1100 (AEDT)
Received: by mail-it0-x242.google.com with SMTP id u12so1745688ite.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Feb 2018 20:20:11 -0800 (PST)
Subject: Re: [kernel] powerpc/pci: Fix broken INTx configuration via OF
To: Michael Ellerman <patch-notifications@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Cc: Rob Herring <robh@kernel.org>, Alistair Popple <alistair@popple.id.au>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <3zd1Yw5kRtz9t3C@ozlabs.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <1cb9bd56-3083-388c-5ad1-90a2b1d107a1@ozlabs.ru>
Date: Fri, 9 Feb 2018 15:20:02 +1100
MIME-Version: 1.0
In-Reply-To: <3zd1Yw5kRtz9t3C@ozlabs.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/02/18 15:00, Michael Ellerman wrote:
> On Thu, 2018-02-08 at 05:33:54 UTC, Alexey Kardashevskiy wrote:
>> Commit 59f47eff03a0 ("powerpc/pci: Use of_irq_parse_and_map_pci() helper")
>> correctly states that of_irq_parse_and_map_pci() does the same thing as
>> of_irq_parse_pci() does as it simply calls
>> of_irq_parse_pci() and irq_create_of_mapping().
>>
>> However of_irq_parse_and_map_pci() not only returns 0 for success and
>> negative value for an error but also a positive virq value from
>> irq_create_of_mapping() which the mentioned commit ignores and
>> INTx config fails.
>>
>> This fixes the of_irq_parse_and_map_pci() return value handling.
>>
>> Fixes: 59f47eff03a0 "powerpc/pci: Use of_irq_parse_and_map_pci() helper"
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> Applied to powerpc fixes, thanks.
> 
> https://git.kernel.org/powerpc/c/560c0f978155282e36f33d21b2aeae


there is a v2, this one is not 100% correct


-- 
Alexey
