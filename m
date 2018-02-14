Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zhL5p6X5czF1G3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 00:36:14 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Laurent Vivier <lvivier@redhat.com>,
 Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH kernel v2] powerpc/mm: Flush radix process translations
 when setting MMU type
In-Reply-To: <fe81336d-d356-59be-663b-2b81d7d407fd@redhat.com>
References: <20180201050944.30332-1-aik@ozlabs.ru>
 <fb14f2b5-03a3-c20b-b729-643d6a79504a@redhat.com>
 <f30971fd-a4a8-ceb6-bf0a-b293275c8d0b@linux.vnet.ibm.com>
 <fe81336d-d356-59be-663b-2b81d7d407fd@redhat.com>
Date: Thu, 15 Feb 2018 00:36:14 +1100
Message-ID: <877erfr8vl.fsf@concordia.ellerman.id.au>
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

Laurent Vivier <lvivier@redhat.com> writes:
> On 07/02/2018 18:49, Daniel Henrique Barboza wrote:
>> On 02/07/2018 12:33 PM, Laurent Vivier wrote:
>>> On 01/02/2018 06:09, Alexey Kardashevskiy wrote:
>>>> Radix guests do normally invalidate process-scoped translations when
>>>> a new pid is allocated but migrated guests do not invalidate these so
>>>> migrated guests crash sometime, especially easy to reproduce with
>>>> migration happening within first 10 seconds after the guest boot
>>>> start on
>>>> the same machine.
>>>>
>>>> This adds the "Invalidate process-scoped translations" flush to fix
>>>> radix guests migration.
>>>>
>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
...
>>>
>>> Tested-by: Laurent Vivier <lvivier@redhat.com>
>
> Any hope to have this patch merged soon?
>
> It fixes a real problem and migration of VM is not reliable without it.

Sorry it got lost in the merge window / rc1 madness. It's in my fixes
branch now and heading to Linus.

cheers
