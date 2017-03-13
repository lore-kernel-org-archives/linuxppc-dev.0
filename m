Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vhlKw4JS2zDqXy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 04:32:04 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2DHIqDW065099
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 13:31:53 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 294e97q05q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 13:31:53 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Tue, 14 Mar 2017 03:31:50 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2DHVd1E50528278
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 04:31:47 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2DHVE45004160
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 04:31:14 +1100
Subject: Re: 4.11.0-rc1 boot resulted in WARNING: CPU: 14 PID: 1722 at
 fs/sysfs/dir.c:31 .sysfs_warn_dup+0x78/0xb0
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Brian Foster <bfoster@redhat.com>, linux-xfs@vger.kernel.org,
 linux-block@vger.kernel.org, mpe@ellerman.id, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Date: Mon, 13 Mar 2017 23:00:27 +0530
In-Reply-To: <158127ce-d71d-56a5-3dd3-f676b106c65d@kernel.dk>
References: <1488904264.3961.17.camel@abdul-ThinkPad-T450>
 <20170308131705.GB23404@bfoster.bfoster>
 <1489056606.3961.41.camel@abdul-ThinkPad-T450>
 <20170309125919.GA16713@bfoster.bfoster>
 <158127ce-d71d-56a5-3dd3-f676b106c65d@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1489426227.19698.36.camel@abdul>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2017-03-11 at 15:46 -0700, Jens Axboe wrote:
> On 03/09/2017 05:59 AM, Brian Foster wrote:
> > cc linux-block
> > 
> > On Thu, Mar 09, 2017 at 04:20:06PM +0530, Abdul Haleem wrote:
> >> On Wed, 2017-03-08 at 08:17 -0500, Brian Foster wrote:
> >>> On Tue, Mar 07, 2017 at 10:01:04PM +0530, Abdul Haleem wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> Today's mainline (4.11.0-rc1) booted with warnings on Power7 LPAR.
> >>>>
> >>>> Issue is not reproducible all the time.
> 
> Is that still the case with -git as of yesterday? Check that you
> have this merge:
> 
> 34bbce9e344b47e8871273409632f525973afad4
> 
> in your tree.
> 

Thanks for pointing out, with the below merge commit warnings disappear.

commit 34bbce9e344b47e8871273409632f525973afad4
Merge: bb61ce5 672a2c8
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Mar 9 15:53:25 2017 -0800

    Merge branch 'for-linus' of git://git.kernel.dk/linux-block


Thanks for the fix !

Reported-by & Tested-by : Abdul Haleem <abdhalee@linux.vnet.ibm.com>

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
