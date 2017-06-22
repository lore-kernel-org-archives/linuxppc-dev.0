Return-Path: <srs0=c33n=53=suse.de=msuchanek@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtdwn2Q2lzDqRW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 21:03:21 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wtdwn1ktrz8sxk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 21:03:21 +1000 (AEST)
Date: Thu, 22 Jun 2017 13:03:15 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: victora <victora@linux.vnet.ibm.com>
Cc: alistair@popple.id.au, jk@ozlabs.org, victora@br.ibm.com,
 mauricfo@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org
Subject: Re: 1M hugepage size being registered on Linux
Message-ID: <20170622130315.570c8da3@kitsune.suse.cz>
In-Reply-To: <322aa4a1a11ca79008a8c894c12a80d5@linux.vnet.ibm.com>
References: <322aa4a1a11ca79008a8c894c12a80d5@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 20 Jun 2017 10:47:47 -0300
victora <victora@linux.vnet.ibm.com> wrote:

> Hi Alistair/Jeremy,
> 
> I am working on a bug related to 1M hugepage size being registered on 
> Linux (Power 8 Baremetal - Garrison).
> 
> I was checking dmesg and it seems that 1M page size is coming from 
> firmware to Linux.
> 
> [    0.000000] base_shift=20: shift=20, sllp=0x0130,
> avpnm=0x00000000, tlbiel=0, penc=2
> [    1.528867] HugeTLB registered 1 MB page size, pre-allocated 0
> pages
> 
> Should Linux support this page size? As afar as I know, this was an 
> unsupported page size in the past isn't it? If this should be
> supported now, is there any specific reason for that?

Hello,

a525108cf1cc powerpc/mm/hugetlb: Filter out hugepage size not supported
by page table layout

Should reject unsupported huge page sizes, right?

Thanks

Michal
