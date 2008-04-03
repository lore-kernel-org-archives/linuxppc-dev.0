Return-Path: <yhlu.kernel@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.236])
	by ozlabs.org (Postfix) with ESMTP id F3279DDE1D
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 15:16:07 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so2910199wxd.15
	for <linuxppc-dev@ozlabs.org>; Wed, 02 Apr 2008 21:16:06 -0700 (PDT)
Message-ID: <86802c440804022116j2a8fb745pf734f61542a8e287@mail.gmail.com>
Date: Wed, 2 Apr 2008 21:16:05 -0700
From: "Yinghai Lu" <yhlu.kernel@gmail.com>
To: "Andrew Morton" <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: make mem_map allocation continuous v2.
In-Reply-To: <20080402192223.5e8754a0.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200804021525.48799.yhlu.kernel@gmail.com>
	<20080402155247.5e746be7.akpm@linux-foundation.org>
	<86802c440804021744m7c6e3d94vcb6af3ebcaa71b5b@mail.gmail.com>
	<200804021830.24563.yhlu.kernel@gmail.com>
	<20080402192223.5e8754a0.akpm@linux-foundation.org>
Cc: kernel list <linux-kernel@vger.kernel.org>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>, linuxppc-dev@ozlabs.org,
	Badari Pulavarty <pbadari@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 2, 2008 at 7:22 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Wed, 2 Apr 2008 18:30:24 -0700 Yinghai Lu <yhlu.kernel.send@gmail.com> wrote:
>
>  > v2 replace:
>  >       [PATCH] mm: make mem_map allocation continuous.
>  >       [PATCH] mm: allocate section_map for sparse_init
>  >       [PATCH] mm: allocate usemap at first instead of mem_map in sparse_init
>  >
>
>  err, no.
>
>
>  >
>  > diff --git a/mm/sparse.c b/mm/sparse.c
>  > index f6a43c0..2881222 100644
>  > --- a/mm/sparse.c
>  > +++ b/mm/sparse.c
>
>  Sorry, but I'd rather not do it this way.  We presently have this:
>

it replaces

>  mm-make-mem_map-allocation-continuous.patch
>  mm-make-mem_map-allocation-continuous-checkpatch-fixes.patch
>  mm-allocate-section_map-for-sparse_init.patch
>  mm-allocate-section_map-for-sparse_init-update.patch
>  mm-allocate-section_map-for-sparse_init-update-fix.patch
>  mm-allocate-section_map-for-sparse_init-powerpc-fix.patch

others still needed

so mm-make-mem-map-allocation-continuous.patch will not break powerpc and ia64

YH
