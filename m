Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4014wr3K15zDq66
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 06:41:31 +1100 (AEDT)
Date: Tue, 13 Mar 2018 12:41:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: mhocko@suse.com, catalin.marinas@arm.com, pasha.tatashin@oracle.com,
 takahiro.akashi@linaro.org, gi-oh.kim@profitbricks.com, npiggin@gmail.com,
 baiyaowei@cmss.chinamobile.com, bob.picco@oracle.com,
 ard.biesheuvel@linaro.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: OK to merge via powerpc? (was Re: [PATCH 05/14] mm: make
 memblock_alloc_base_nid non-static)
Message-Id: <20180313124128.875efd39a5d3ce9a9bb37e63@linux-foundation.org>
In-Reply-To: <873714goxg.fsf@concordia.ellerman.id.au>
References: <20180213150824.27689-1-npiggin@gmail.com>
 <20180213150824.27689-6-npiggin@gmail.com>
 <873714goxg.fsf@concordia.ellerman.id.au>
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

On Tue, 13 Mar 2018 23:06:35 +1100 Michael Ellerman <mpe@ellerman.id.au> wrote:

> Anyone object to us merging the following patch via the powerpc tree?
> 
> Full series is here if anyone's interested:
>   http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=28377&state=*
> 

Yup, please go ahead.

I assume the change to the memblock_alloc_range() declaration was an
unrelated, unchangelogged cleanup.
