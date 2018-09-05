Return-Path: <rppt@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4259Sw6xY9zF37t
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 03:20:32 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w85HJKaI068888
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Sep 2018 13:20:30 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2majekjthc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Sep 2018 13:20:29 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rppt@linux.vnet.ibm.com>;
 Wed, 5 Sep 2018 18:20:27 +0100
Date: Wed, 5 Sep 2018 20:20:18 +0300
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Rob Herring <robh@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 davem@davemloft.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 mingo@redhat.com, Michael Ellerman <mpe@ellerman.id.au>,
 mhocko@suse.com, paul.burton@mips.com,
 Thomas Gleixner <tglx@linutronix.de>, tony.luck@intel.com,
 linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 07/29] memblock: remove _virt from APIs returning
 virtual address
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536163184-26356-8-git-send-email-rppt@linux.vnet.ibm.com>
 <CABGGiswdb1x-=vqrgxZ9i2dnLdsgtXq4+5H9Y1JRd90YVMW69A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABGGiswdb1x-=vqrgxZ9i2dnLdsgtXq4+5H9Y1JRd90YVMW69A@mail.gmail.com>
Message-Id: <20180905172017.GA2203@rapoport-lnx>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 05, 2018 at 12:04:36PM -0500, Rob Herring wrote:
> On Wed, Sep 5, 2018 at 11:00 AM Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> >
> > The conversion is done using
> >
> > sed -i 's@memblock_virt_alloc@memblock_alloc@g' \
> >         $(git grep -l memblock_virt_alloc)
> 
> What's the reason to do this? It seems like a lot of churn even if a
> mechanical change.

I felt that memblock_virt_alloc_ is too long for a prefix, e.g:
memblock_virt_alloc_node_nopanic, memblock_virt_alloc_low_nopanic.

And for consistency I've changed the memblock_virt_alloc as well.


> Rob
> 

-- 
Sincerely yours,
Mike.
