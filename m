Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wv6PY10NszDqnm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 15:26:25 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>, victora
 <victora@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, alistair@popple.id.au, mauricfo@linux.vnet.ibm.com,
 jk@ozlabs.org, victora@br.ibm.com
Subject: Re: 1M hugepage size being registered on Linux
In-Reply-To: <20170622130315.570c8da3@kitsune.suse.cz>
References: <322aa4a1a11ca79008a8c894c12a80d5@linux.vnet.ibm.com>
 <20170622130315.570c8da3@kitsune.suse.cz>
Date: Fri, 23 Jun 2017 15:26:24 +1000
Message-ID: <874lv7qnpb.fsf@concordia.ellerman.id.au>
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

Michal Such=C3=A1nek <msuchanek@suse.de> writes:

> On Tue, 20 Jun 2017 10:47:47 -0300
> victora <victora@linux.vnet.ibm.com> wrote:
>
>> Hi Alistair/Jeremy,
>>=20
>> I am working on a bug related to 1M hugepage size being registered on=20
>> Linux (Power 8 Baremetal - Garrison).
>>=20
>> I was checking dmesg and it seems that 1M page size is coming from=20
>> firmware to Linux.
>>=20
>> [    0.000000] base_shift=3D20: shift=3D20, sllp=3D0x0130,
>> avpnm=3D0x00000000, tlbiel=3D0, penc=3D2
>> [    1.528867] HugeTLB registered 1 MB page size, pre-allocated 0
>> pages
>>=20
>> Should Linux support this page size? As afar as I know, this was an=20
>> unsupported page size in the past isn't it? If this should be
>> supported now, is there any specific reason for that?
>
> Hello,
>
> a525108cf1cc powerpc/mm/hugetlb: Filter out hugepage size not supported
> by page table layout
>
> Should reject unsupported huge page sizes, right?

Yes, see my reply.

cheers
