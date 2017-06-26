Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wwvL96vTXzDr0c
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 13:14:41 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: victora <victora@linux.vnet.ibm.com>
Cc: alistair@popple.id.au, jk@ozlabs.org, victora@br.ibm.com,
 mauricfo@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org
Subject: Re: 1M hugepage size being registered on Linux
In-Reply-To: <fd47f4ad5f3589d4d9b6fc7253615c22@linux.vnet.ibm.com>
References: <322aa4a1a11ca79008a8c894c12a80d5@linux.vnet.ibm.com>
 <87o9tgsmdv.fsf@concordia.ellerman.id.au>
 <fd47f4ad5f3589d4d9b6fc7253615c22@linux.vnet.ibm.com>
Date: Mon, 26 Jun 2017 13:14:41 +1000
Message-ID: <87fuenphi6.fsf@concordia.ellerman.id.au>
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

victora <victora@linux.vnet.ibm.com> writes:
> Em 2017-06-22 00:59, Michael Ellerman escreveu:
>> 
>> We merged a patch from Aneesh to filter it out in 4.12-rc1:
>> 
>>   a525108cf1cc ("powerpc/mm/hugetlb: Filter out hugepage size not
>> supported by page table layout")
>> 
>> I guess we should probably send that patch to stable et. al.
              ^
              :)
>
> Sorry for the delay. Thanks for merging that patch.
> Was that patch also sent to stable et. al.?

No it wasn't.

cheers
