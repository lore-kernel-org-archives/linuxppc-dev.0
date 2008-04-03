Return-Path: <yhlu.kernel@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.188])
	by ozlabs.org (Postfix) with ESMTP id 17813DDE0A
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 12:43:26 +1100 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so1683700rvf.9
	for <linuxppc-dev@ozlabs.org>; Wed, 02 Apr 2008 18:43:24 -0700 (PDT)
Message-ID: <86802c440804021843i57f5e82fsee5121bf97d65909@mail.gmail.com>
Date: Wed, 2 Apr 2008 18:43:24 -0700
From: "Yinghai Lu" <yhlu.kernel@gmail.com>
To: "Andrew Morton" <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: allocate usemap at first instead of mem_map in
	sparse_init
In-Reply-To: <86802c440804021744m7c6e3d94vcb6af3ebcaa71b5b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200804021525.48799.yhlu.kernel@gmail.com>
	<20080402155247.5e746be7.akpm@linux-foundation.org>
	<86802c440804021744m7c6e3d94vcb6af3ebcaa71b5b@mail.gmail.com>
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

On Wed, Apr 2, 2008 at 5:44 PM, Yinghai Lu <yhlu.kernel@gmail.com> wrote:
>
> On Wed, Apr 2, 2008 at 3:52 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
>  >
>  > On Wed, 2 Apr 2008 15:25:48 -0700 Yinghai Lu <yhlu.kernel.send@gmail.com> wrote:
>  >
>  >  > [PATCH] mm: allocate usemap at first instead of mem_map in sparse_init
>  >  >
>  >  > on powerpc,
>  >  >
>  >  > On Wed, Apr 2, 2008 at 12:22 PM, Badari Pulavarty <pbadari@us.ibm.com> wrote:
>  >  > >
>  >  > > On Wed, 2008-04-02 at 18:17 +1100, Michael Ellerman wrote:
>  >  > >  > On Wed, 2008-04-02 at 12:38 +0530, Kamalesh Babulal wrote:
>  >  > >  > > Andrew Morton wrote:
>  >  > >  > > > On Wed, 02 Apr 2008 11:55:36 +0530 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> wrote:
>  >  > so try to allocate usemap at first altogether.
>  >
>  >  I have to turn all the above crud into a proper changelog.  I'd prefer that
>  >  you do it.
>  >
>  >  Unless this patch should be folded into another one, in which case it
>  >  doesn't matter.
>  >
>  >
>  >  > Signed-off-by: Yinghai Lu <yhlu.kernel@gmail.com>
>  >  >
>  >  > diff --git a/mm/sparse.c b/mm/sparse.c
>  >  > index d3cb085..782ebe5 100644
>  >  > --- a/mm/sparse.c
>  >  > +++ b/mm/sparse.c
>  >
>  >  We shouldn't merge this patch on its own because then that will leave a
>  >  non-bisectable region in the powerpc history.
>  >
>  >  So which patch is this patch fixing?  Lexically it applies to
>  >  mm-allocate-section_map-for-sparse_init.patch (and its updates).  But is
>  >  that where it logically lies?
>
>  yes. we should fold
>
>
>  mm-make-mem_map-allocation-continuous.patch
>
> mm-allocate-section_map-for-sparse_init.patch
>  and this one
>

please check the big one.
http://lkml.org/lkml/2008/4/2/650

YH
