Return-Path: <robinmholt@gmail.com>
Received: from mail-ie0-x22d.google.com (mail-ie0-x22d.google.com
 [IPv6:2607:f8b0:4001:c03::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B6FA41A19C1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 00:14:42 +1000 (AEST)
Received: by iecri3 with SMTP id ri3so48284533iec.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 07:14:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1437486951-19898-1-git-send-email-vbabka@suse.cz>
References: <1437486951-19898-1-git-send-email-vbabka@suse.cz>
Date: Tue, 21 Jul 2015 09:14:40 -0500
Message-ID: <CAPp3RGryq96pEErEw8x=UV_=xsZS4ACD15uAEaOVT5CgcLzzEQ@mail.gmail.com>
Subject: Re: [PATCH] mm: rename and document alloc_pages_exact_node
From: Robin Holt <robinmholt@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-ia64@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Christoph Lameter <cl@linux.com>,
 Cliff Whickman <cpw@sgi.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 21, 2015 at 8:55 AM, Vlastimil Babka <vbabka@suse.cz> wrote:
> The function alloc_pages_exact_node() was introduced in 6484eb3e2a81 ("page
> allocator: do not check NUMA node ID when the caller knows the node is valid")
> as an optimized variant of alloc_pages_node(), that doesn't allow the node id
> to be -1. Unfortunately the name of the function can easily suggest that the
> allocation is restricted to the given node. In truth, the node is only
> preferred, unless __GFP_THISNODE is among the gfp flags.
>
...
> Cc: Robin Holt <robinmholt@gmail.com>

Acked-by: Robin Holt <robinmholt@gmail.com>
