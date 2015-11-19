Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42BF51A0757
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2015 11:21:58 +1100 (AEDT)
Received: by padhx2 with SMTP id hx2so60817719pad.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2015 16:21:56 -0800 (PST)
Subject: Re: [PATCH v7 25/50] powerpc/powernv: Reserve PE for root bus
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-26-git-send-email-gwshan@linux.vnet.ibm.com>
 <564AC37A.2060701@ozlabs.ru> <20151117090653.GA20134@gwshan>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <564D161C.3020603@ozlabs.ru>
Date: Thu, 19 Nov 2015 11:21:48 +1100
MIME-Version: 1.0
In-Reply-To: <20151117090653.GA20134@gwshan>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/17/2015 08:06 PM, Gavin Shan wrote:
> On Tue, Nov 17, 2015 at 05:04:42PM +1100, Alexey Kardashevskiy wrote:
>> On 11/05/2015 12:12 AM, Gavin Shan wrote:
>>> We're going to reserve/assign PEs when pcibios_setup_bridge() is
>>> called. The function won't be called for root bus as it doesn't
>>> have parent bridge. However, the root bus still needs a PE to be
>>> covered.
>>>
>>> This reserves PE numbers that are adjacent to the reserved one
>>> for root buses.
>>
>>
>> Somewhere in the patchset you need to describe why you need a separate PE for
>> a root bus and why reserved_pe_idx is not enough for this.
>>
>
> Please confirm if it's fine to add the descrption in this patch's chagelog.

Yes, it is fine. Thanks!


-- 
Alexey
