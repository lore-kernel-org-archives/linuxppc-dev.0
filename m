Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F228A1A08D8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 08:11:31 +1100 (AEDT)
Date: Fri, 16 Oct 2015 14:11:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, xemul@parallels.com,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 benh@kernel.crashing.org, aneesh.kumar@linux.vnet.ibm.com,
 paulus@samba.org, criu@openvz.org
Subject: Re: [PATCH 0/3] mm/powerpc: enabling memory soft dirty tracking
Message-Id: <20151016141129.8b014c6d882c475fafe577a9@linux-foundation.org>
In-Reply-To: <cover.1444995096.git.ldufour@linux.vnet.ibm.com>
References: <cover.1444995096.git.ldufour@linux.vnet.ibm.com>
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

On Fri, 16 Oct 2015 14:07:05 +0200 Laurent Dufour <ldufour@linux.vnet.ibm.com> wrote:

> This series is enabling the software memory dirty tracking in the
> kernel for powerpc.  This is the follow up of the commit 0f8975ec4db2
> ("mm: soft-dirty bits for user memory changes tracking") which
> introduced this feature in the mm code.
> 
> The first patch is fixing an issue in the code clearing the soft dirty
> bit.  The PTE were not cleared before being modified, leading to hang
> on ppc64.
> 
> The second patch is fixing a build issue when the transparent huge
> page is not enabled.
> 
> The third patch is introducing the soft dirty tracking in the powerpc
> architecture code. 

I grabbed these patches, but they're more a ppc thing than a core
kernel thing.  I can merge them into 4.3 with suitable acks or drop
them if they turn up in the powerpc tree.  Or something else?
