Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xB24X6VLKzDrD8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 22:03:24 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id z1so4208472pgs.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 05:03:24 -0700 (PDT)
Message-ID: <1500292950.8256.16.camel@gmail.com>
Subject: Re: [PATCH/RFC] powerpc: Better handle "error" type page faults on
 book3s64
From: Balbir Singh <bsingharora@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <patch-notifications@ellerman.id.au>, "Aneesh Kumar K
 . V" <aneesh.kumar@linux.vnet.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Date: Mon, 17 Jul 2017 22:02:30 +1000
In-Reply-To: <1500021087.2865.86.camel@kernel.crashing.org>
References: <1500021087.2865.86.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-07-14 at 18:31 +1000, Benjamin Herrenschmidt wrote:
> There are a number of conditions in the DSISR that represent
> conditions for which there is no point looking for a VMA or
> trying to update a PTE. In fact, POWER9 adds a few with bad
> AMOs, bad "paste" instruction etc...
> 
> This improve our existing code to use symbolic constants for
> all DSISR bits, properly avoid hash_page() for the new bits,
> and handle both the old and new bits early in do_page_fault()
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> --
>

Looks reasonable

Acked-by: Balbir Singh <bsingharora@gmail.com> 
