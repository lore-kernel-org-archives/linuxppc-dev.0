Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtfFc3hwTzDq8c
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 21:17:56 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: benh@au1.ibm.com, victora <victora@linux.vnet.ibm.com>,
 alistair@popple.id.au, jk@ozlabs.org
Cc: victora@br.ibm.com, mauricfo@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org
Subject: Re: 1M hugepage size being registered on Linux
In-Reply-To: <1498118971.31581.65.camel@au1.ibm.com>
References: <322aa4a1a11ca79008a8c894c12a80d5@linux.vnet.ibm.com>
 <87o9tgsmdv.fsf@concordia.ellerman.id.au>
 <1498118971.31581.65.camel@au1.ibm.com>
Date: Thu, 22 Jun 2017 21:17:52 +1000
Message-ID: <87zid0qnj3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@au1.ibm.com> writes:

> On Thu, 2017-06-22 at 13:59 +1000, Michael Ellerman wrote:
>> It's unsupported in Linux because it doesn't match the page table
>> geometry.
>>=20
>> We merged a patch from Aneesh to filter it out in 4.12-rc1:
>>=20
>> =C2=A0 a525108cf1cc ("powerpc/mm/hugetlb: Filter out hugepage size not s=
upported by page table layout")
>>=20
>> I guess we should probably send that patch to stable et. al.
>
> It's also not supported in HW afaik, why is it there ?

Because hostboot said so AIUI.

cheers
