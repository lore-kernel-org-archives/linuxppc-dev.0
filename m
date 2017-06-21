Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wt1JN4WphzDq88
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 20:33:08 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: victora <victora@linux.vnet.ibm.com>, alistair@popple.id.au, jk@ozlabs.org
Cc: victora@br.ibm.com, mauricfo@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
 Benjamin Herrenschmidt  <benh@kernel.crashing.org>
Subject: Re: 1M hugepage size being registered on Linux
In-Reply-To: <322aa4a1a11ca79008a8c894c12a80d5@linux.vnet.ibm.com>
References: <322aa4a1a11ca79008a8c894c12a80d5@linux.vnet.ibm.com>
Date: Wed, 21 Jun 2017 20:33:07 +1000
Message-ID: <87wp85sk9o.fsf@concordia.ellerman.id.au>
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

> Hi Alistair/Jeremy,
>
> I am working on a bug related to 1M hugepage size being registered on 
> Linux (Power 8 Baremetal - Garrison).

Wasn't that caused by a firmware bug?

> I was checking dmesg and it seems that 1M page size is coming from 
> firmware to Linux.
>
> [    0.000000] base_shift=20: shift=20, sllp=0x0130, avpnm=0x00000000, 
> tlbiel=0, penc=2
> [    1.528867] HugeTLB registered 1 MB page size, pre-allocated 0 pages
>
> Should Linux support this page size?

Does it work? :)

The user manual says it's a supported size, but I thought it didn't work
(in hardware) for some reason.

cheers
