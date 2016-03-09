Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 108FC1A0033
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 08:42:25 +1100 (AEDT)
Date: Wed, 9 Mar 2016 13:42:22 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Li Zhang <zhlcindy@gmail.com>, vbabka@suse.cz,
 mgorman@techsingularity.net, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Li Zhang
 <zhlcindy@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] powerpc/mm: Enable page parallel initialisation
Message-Id: <20160309134222.9c3c7df3dd16956bf7d0c657@linux-foundation.org>
In-Reply-To: <1457429794.31524.1.camel@ellerman.id.au>
References: <1457409354-10867-1-git-send-email-zhlcindy@gmail.com>
 <1457409354-10867-3-git-send-email-zhlcindy@gmail.com>
 <1457429794.31524.1.camel@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 08 Mar 2016 20:36:34 +1100 Michael Ellerman <mpe@ellerman.id.au> wrote:

> Given that, I think it would be best if Andrew merged both of these patches.
> Because this patch is pretty trivial, whereas the patch to mm/ is less so.
> 
> Is that OK Andrew?

Yep, no probs.
