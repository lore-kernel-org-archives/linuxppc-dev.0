Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D729B1A2AAB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 10:32:44 +1100 (AEDT)
Message-ID: <1427067149.4770.209.camel@kernel.crashing.org>
Subject: Re: [PATCH v5 RFC 0/3] Generic IOMMU pooled allocator
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Mon, 23 Mar 2015 10:32:29 +1100
In-Reply-To: <cover.1426986386.git.sowmini.varadhan@oracle.com>
References: <cover.1426986386.git.sowmini.varadhan@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2015-03-22 at 15:22 -0400, Sowmini Varadhan wrote:
> Follows up on the feedback in the thread at
>   http://www.spinics.net/lists/sparclinux/msg13493.html
> 
> - removed ->cookie_to_index and ->demap indirection from the iommu_tbl_ops
>   The caller needs to call these functions as needed, before invoking
>   the generic arena allocator functions.
> 
> - added the "skip_span_boundary" argument to iommu_tbl_pool_init() for
>   those callers like LDC which do no care about span boundary checks.

Thanks. I'll try to look in depth some time this week, but poke me if
you don't hear from me, I'm a bit swamped at the moment. In the
meantime, Alexey might have some bandwidth to also check it out.

Cheers,
Ben.
