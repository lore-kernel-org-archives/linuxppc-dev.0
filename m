Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41KqbM26gszF1QS
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2018 02:39:42 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w63GdcvE069830
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Jul 2018 12:39:40 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2k09su900v-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Jul 2018 12:39:39 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Tue, 3 Jul 2018 12:39:18 -0400
Subject: Re: Oops in kmem_cache_free() via bioset_exit() (was Re:
 [next-20180601][nvme][ppc] Kernel Oops is triggered when creating lvm
 snapshots on nvme disks)
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>, linux-next <linux-next@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, linux-scsi
 <linux-scsi@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
 sachinp <sachinp@linux.vnet.ibm.com>, sim <sim@linux.vnet.ibm.com>,
 manvanth <manvanth@linux.vnet.ibm.com>, Brian King
 <brking@linux.vnet.ibm.com>, linux-block@vger.kernel.org, Kent Overstreet
 <kent.overstreet@gmail.com>, Jens Axboe <axboe@kernel.dk>
Date: Tue, 03 Jul 2018 22:09:06 +0530
In-Reply-To: <87a7rf55vy.fsf@concordia.ellerman.id.au>
References: <1530003645.24245.7.camel@abdul.in.ibm.com>
 <87d0wd7jph.fsf@concordia.ellerman.id.au>
 <1530176707.24245.12.camel@abdul.in.ibm.com>
 <87a7rf55vy.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1530635946.24245.15.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-06-29 at 00:42 +1000, Michael Ellerman wrote:
> Kent, Jens,
> 
> This looks like it might be related to the recent bioset changes?
> 
> cheers
> 
> Abdul Haleem <abdhalee@linux.vnet.ibm.com> writes:
> > On Tue, 2018-06-26 at 23:36 +1000, Michael Ellerman wrote:
> >> Abdul Haleem <abdhalee@linux.vnet.ibm.com> writes:
> ...
> > I was able to reproduce again with slub_debug=FZP and DEBUG_INFO enabled
> > on 4.17.0-rc7-next-20180601, but not much traces other than the Oops stack trace
> 
> Are you still testing on that revision? It's nearly a month old.
> 
> Please try to reproduce on mainline or today's linux-next.

Problem is not reproducible on 4.18.0-rc3 mainline and today's next
kernel

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
