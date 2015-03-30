Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B40661A0079
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 23:32:15 +1100 (AEDT)
In-Reply-To: <1427261761-22952-4-git-send-email-dja@axtens.net>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 03/27] powerpc/swiotlb: give init call a less misleading
 name
Message-Id: <20150330123215.99036140082@ozlabs.org>
Date: Mon, 30 Mar 2015 23:32:14 +1100 (AEDT)
Cc: Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-25-03 at 05:35:37 UTC, Daniel Axtens wrote:
> swiotlb_late_init sets up platform specific hooks. It's not actually
> a late initcall, but a subsys initcall, called much earlier.
> 
> Ideally we'd call it swiotlb_init, but that's taken.
> Call it swiotlb_subsys_init for now.
> (It will be refactored and renamed later.)

AFAICS you just end up renaming this anyway, so I don't think you need to
bother with this patch.

cheers
