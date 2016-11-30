Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tT1zz4yJDzDvnp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 11:50:39 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id 144so9096255pfv.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 16:50:39 -0800 (PST)
Subject: Re: [PATCH v7 3/7] powerpc/mm: Introduce _PAGE_LARGE software pte bits
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org,
 mpe@ellerman.id.au
References: <20161128061704.4914-1-aneesh.kumar@linux.vnet.ibm.com>
 <20161128061704.4914-4-aneesh.kumar@linux.vnet.ibm.com>
 <2b65879e-e0c7-f915-b622-290899e41031@gmail.com>
 <1480466113.3459.2.camel@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <dbe2f49e-8192-890a-6d94-16639bc9b1a7@gmail.com>
Date: Wed, 30 Nov 2016 11:50:32 +1100
MIME-Version: 1.0
In-Reply-To: <1480466113.3459.2.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 30/11/16 11:35, Benjamin Herrenschmidt wrote:
> On Wed, 2016-11-30 at 11:14 +1100, Balbir Singh wrote:
>>> +#define _RPAGE_RSV1          0x1000000000000000UL
>>> +#define _RPAGE_RSV2          0x0800000000000000UL
>>> +#define _RPAGE_RSV3          0x0400000000000000UL
>>> +#define _RPAGE_RSV4          0x0200000000000000UL
>>> +
>>
>> We use the top 4 bits and not the _SW bits?
> 
> Correct, welcome to the discussion we've been having the last 2 weeks
> :-)
> 

I thought we were following Paul's suggestion here

https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-November/151620.html
and I also noticed
https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-November/151624.html

My bad, I thought we had two SW bits to use for DD1

Balbir Singh.
