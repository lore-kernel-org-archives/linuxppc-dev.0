Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401CwT19NhzF0pl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 11:56:40 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id g8so657642pgv.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 17:56:40 -0700 (PDT)
Date: Wed, 14 Mar 2018 10:56:20 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, mhocko@suse.com,
 catalin.marinas@arm.com, pasha.tatashin@oracle.com,
 takahiro.akashi@linaro.org, gi-oh.kim@profitbricks.com,
 baiyaowei@cmss.chinamobile.com, bob.picco@oracle.com,
 ard.biesheuvel@linaro.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: OK to merge via powerpc? (was Re: [PATCH 05/14] mm: make
 memblock_alloc_base_nid non-static)
Message-ID: <20180314105620.5d98ff9f@roar.ozlabs.ibm.com>
In-Reply-To: <20180313124128.875efd39a5d3ce9a9bb37e63@linux-foundation.org>
References: <20180213150824.27689-1-npiggin@gmail.com>
 <20180213150824.27689-6-npiggin@gmail.com>
 <873714goxg.fsf@concordia.ellerman.id.au>
 <20180313124128.875efd39a5d3ce9a9bb37e63@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 13 Mar 2018 12:41:28 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 13 Mar 2018 23:06:35 +1100 Michael Ellerman <mpe@ellerman.id.au> wrote:
> 
> > Anyone object to us merging the following patch via the powerpc tree?
> > 
> > Full series is here if anyone's interested:
> >   http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=28377&state=*
> >   
> 
> Yup, please go ahead.
> 
> I assume the change to the memblock_alloc_range() declaration was an
> unrelated, unchangelogged cleanup.
> 

It is. I'm trying to get better at that. Michael might drop that bit if
he's not already sick of fixing up my patches...

Thanks,
Nick
