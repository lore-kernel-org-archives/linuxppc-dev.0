Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wypg55CnKzDr1h
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 15:50:57 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, benh@kernel.crashing.org,
 paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Build fix for non SPARSEMEM_VMEMAP config
In-Reply-To: <bb3cb2f5-12dd-0b0d-0b2a-ca5de2d1f6bf@linux.vnet.ibm.com>
References: <1498630168-26376-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <bb344453-f49d-aff1-8f9c-732b8a40cbfa@ozlabs.ru>
 <bb3cb2f5-12dd-0b0d-0b2a-ca5de2d1f6bf@linux.vnet.ibm.com>
Date: Thu, 29 Jun 2017 15:50:57 +1000
Message-ID: <878tkbbav2.fsf@concordia.ellerman.id.au>
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

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> On Wednesday 28 June 2017 12:48 PM, Alexey Kardashevskiy wrote:
>> On 28/06/17 16:09, Aneesh Kumar K.V wrote:
>>> We can use pfn_to_page in realmode for other configs. Hence remove the
>>> CONFIG_FLATMEM ifdef
>> 
>> For CONFIG_SPARSEMEM and CONFIG_DISCONTIGMEM and others (I am struggling to
>> find the full list :) )? Are you sure about that? If I recall correctly, at
>> the time realmode_pfn_to_page() could not work for all of them, what changed?
>
> That is one thing I wanted to check. Everything other than 
> SPARSEMEM_VMEMMAP should use linear mapping which can work with real 
> mode also right ? Or am i missing something ?

I think that's right. But I'm going to make you test it anyway :)

cheers
