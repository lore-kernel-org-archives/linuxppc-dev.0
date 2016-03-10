Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 316CE1A0060
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 11:28:37 +1100 (AEDT)
Message-ID: <1457569716.28944.0.camel@ellerman.id.au>
Subject: Re: [PATCH 2/2] powerpc/mm: Enable page parallel initialisation
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Li Zhang <zhlcindy@gmail.com>, vbabka@suse.cz,
 mgorman@techsingularity.net,  khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Li Zhang
 <zhlcindy@linux.vnet.ibm.com>
Date: Thu, 10 Mar 2016 11:28:36 +1100
In-Reply-To: <20160309134222.9c3c7df3dd16956bf7d0c657@linux-foundation.org>
References: <1457409354-10867-1-git-send-email-zhlcindy@gmail.com>
 <1457409354-10867-3-git-send-email-zhlcindy@gmail.com>
 <1457429794.31524.1.camel@ellerman.id.au>
 <20160309134222.9c3c7df3dd16956bf7d0c657@linux-foundation.org>
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

On Wed, 2016-03-09 at 13:42 -0800, Andrew Morton wrote:
> On Tue, 08 Mar 2016 20:36:34 +1100 Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> > Given that, I think it would be best if Andrew merged both of these patches.
> > Because this patch is pretty trivial, whereas the patch to mm/ is less so.
> >
> > Is that OK Andrew?
>
> Yep, no probs.

Thanks.

cheers
