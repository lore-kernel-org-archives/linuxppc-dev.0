Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wLwDD3xBszDqFx
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 May 2017 18:10:36 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4884RW3093268
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 May 2017 04:10:28 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2aakg44uyp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 May 2017 04:10:23 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Mon, 8 May 2017 17:15:05 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v487E2cq25100392
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 May 2017 17:14:10 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v487Db8Q030718
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 May 2017 17:13:38 +1000
Subject: Re: [linux-next][bock] WARNING: CPU: 22 PID: 0 at
 block/blk-core.c:2655 .blk_update_request+0x4f8/0x500
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block <linux-block@vger.kernel.org>, sachinp
 <sachinp@linux.vnet.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel
 <linux-kernel@vger.kernel.org>
Date: Mon, 08 May 2017 12:43:19 +0530
In-Reply-To: <15a0a50a-d57d-736b-634c-4d0131ec5af3@kernel.dk>
References: <1493965539.7355.44.camel@abdul.in.ibm.com>
 <15a0a50a-d57d-736b-634c-4d0131ec5af3@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1494227599.2983.2.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-05-05 at 08:02 -0600, Jens Axboe wrote:
> On 05/05/2017 12:25 AM, Abdul Haleem wrote:
> > Hi,
> > 
> > 4.11.0 Linus mainline booted with Warnings on PowerPC.
> > 
> > We did not see this on next-20170407 but on next-20170410 and later.
> 
> Have you tried current Linus -git? Both of the -next versions you list
> are rather old.
> 

Hi Jens, 

Warning is still seen with next-20170505 and also with today's mainline.

It was first seen on next-20170410, so the last good was next-20170407.

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
