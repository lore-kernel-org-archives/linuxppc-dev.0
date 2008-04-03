Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [59.145.155.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp05.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 69CBDDDEE2
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 21:49:36 +1100 (EST)
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp05.in.ibm.com (8.13.1/8.13.1) with ESMTP id m33AnDLn027091
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Apr 2008 16:19:13 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m33AnCI11019922
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Apr 2008 16:19:12 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.13.1/8.13.3) with ESMTP id m33AnCdI026600
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Apr 2008 10:49:13 GMT
Message-ID: <47F4B625.7030007@linux.vnet.ibm.com>
Date: Thu, 03 Apr 2008 16:19:09 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Yinghai Lu <yhlu.kernel@gmail.com>
Subject: Re: [PATCH] mm: make mem_map allocation continuous v2.
References: <200804021525.48799.yhlu.kernel@gmail.com>
	<20080402155247.5e746be7.akpm@linux-foundation.org>
	<86802c440804021744m7c6e3d94vcb6af3ebcaa71b5b@mail.gmail.com>
	<200804021830.24563.yhlu.kernel@gmail.com>
	<20080402192223.5e8754a0.akpm@linux-foundation.org>
	<86802c440804022116j2a8fb745pf734f61542a8e287@mail.gmail.com>
In-Reply-To: <86802c440804022116j2a8fb745pf734f61542a8e287@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: kernel list <linux-kernel@vger.kernel.org>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>, linuxppc-dev@ozlabs.org,
	Badari Pulavarty <pbadari@us.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Yinghai Lu wrote:
> On Wed, Apr 2, 2008 at 7:22 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
>> On Wed, 2 Apr 2008 18:30:24 -0700 Yinghai Lu <yhlu.kernel.send@gmail.com> wrote:
>>
>>  > v2 replace:
>>  >       [PATCH] mm: make mem_map allocation continuous.
>>  >       [PATCH] mm: allocate section_map for sparse_init
>>  >       [PATCH] mm: allocate usemap at first instead of mem_map in sparse_init
>>  >
>>
>>  err, no.
>>
>>
>>  >
>>  > diff --git a/mm/sparse.c b/mm/sparse.c
>>  > index f6a43c0..2881222 100644
>>  > --- a/mm/sparse.c
>>  > +++ b/mm/sparse.c
>>
>>  Sorry, but I'd rather not do it this way.  We presently have this:
>>
> 
> it replaces
> 
>>  mm-make-mem_map-allocation-continuous.patch
>>  mm-make-mem_map-allocation-continuous-checkpatch-fixes.patch
>>  mm-allocate-section_map-for-sparse_init.patch
>>  mm-allocate-section_map-for-sparse_init-update.patch
>>  mm-allocate-section_map-for-sparse_init-update-fix.patch
>>  mm-allocate-section_map-for-sparse_init-powerpc-fix.patch
> 
> others still needed
> 
> so mm-make-mem-map-allocation-continuous.patch will not break powerpc and ia64
> 
> YH
Hi,

Thanks, the patch fixes the issue. I am able to bootup without the kernel panic.

Tested-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> 

-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
