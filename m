Return-Path: <cl@linux.com>
Received: from resqmta-ch2-05v.sys.comcast.net
 (resqmta-ch2-05v.sys.comcast.net [IPv6:2001:558:fe21:29:69:252:207:37])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wfRZH3Bg5zDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Jun 2017 00:35:03 +1000 (AEST)
Date: Fri, 2 Jun 2017 09:33:59 -0500 (CDT)
From: Christoph Lameter <cl@linux.com>
To: Hugh Dickins <hughd@google.com>
cc: Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: 4.12-rc ppc64 4k-page needs costly allocations
In-Reply-To: <alpine.LSU.2.11.1706012045240.4854@eggly.anvils>
Message-ID: <alpine.DEB.2.20.1706020932350.28919@east.gentwo.org>
References: <alpine.LSU.2.11.1705301151090.2133@eggly.anvils>
 <87h9014j7t.fsf@concordia.ellerman.id.au>
 <alpine.DEB.2.20.1705310906570.14920@east.gentwo.org>
 <alpine.LSU.2.11.1705311112290.1839@eggly.anvils>
 <alpine.DEB.2.20.1706011027310.8835@east.gentwo.org>
 <alpine.LSU.2.11.1706011002130.3014@eggly.anvils>
 <alpine.DEB.2.20.1706011306560.11993@east.gentwo.org>
 <alpine.LSU.2.11.1706011128490.3622@eggly.anvils>
 <878tlb2igt.fsf@concordia.ellerman.id.au>
 <alpine.LSU.2.11.1706012045240.4854@eggly.anvils>
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 1 Jun 2017, Hugh Dickins wrote:

> SLUB versus SLAB, cpu versus memory?  Since someone has taken the
> trouble to write it with ctors in the past, I didn't feel on firm
> enough ground to recommend such a change.  But it may be obvious
> to someone else that your suggestion would be better (or worse).

Umm how about using alloc_pages() for pageframes?
