Return-Path: <martin.petersen@oracle.com>
Received: from userp1050.oracle.com (userp1050.oracle.com [156.151.31.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xR4bm3HdqzDqkF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 03:42:12 +1000 (AEST)
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by userp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 v77Hg9LV025464
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Aug 2017 17:42:09 GMT
To: Brian King <brking@linux.vnet.ibm.com>
Cc: linux-scsi <linux-scsi@vger.kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Jens Axboe <axboe@kernel.dk>,
 "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,
 Bart Van Assche <Bart.VanAssche@wdc.com>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 Wendy Xiong <wenxiong@linux.vnet.ibm.com>
Subject: Re: [PATCH] ipr: Fix scsi-mq lockdep issue
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <87a83qfosu.fsf@concordia.ellerman.id.au>
 <073ed79c-11ce-e86c-a905-91fd28675d47@kernel.dk>
 <1501166846.2516.1.camel@wdc.com>
 <5b85a365-faa1-3987-9b6b-270399c30686@kernel.dk>
 <87lgn9dqx3.fsf@concordia.ellerman.id.au>
 <92379297-9667-ae52-b05c-6c8a0ce4751c@kernel.dk>
 <OF186C0C54.7E077412-ON8625816B.0053C88E-8625816B.00540312@notes.na.collabserv.com>
 <5dcfe3ac-50c7-86a6-e571-fe5a1c1dc316@linux.vnet.ibm.com>
 <87379c6cfh.fsf@concordia.ellerman.id.au>
 <87a83ju6av.fsf@concordia.ellerman.id.au>
 <6d2bbcc8-3f4b-9b41-45b2-160f4817e439@linux.vnet.ibm.com>
Date: Mon, 07 Aug 2017 13:41:54 -0400
In-Reply-To: <6d2bbcc8-3f4b-9b41-45b2-160f4817e439@linux.vnet.ibm.com> (Brian
 King's message of "Tue, 1 Aug 2017 10:21:30 -0500")
Message-ID: <yq18tiv9swt.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Brian,

> Fixes the following lockdep warning that can occur when scsi-mq is
> enabled with ipr due to ipr calling scsi_unblock_requests from irq
> context. The fix is to move the call to scsi_unblock_requests to ipr's
> existing workqueue.

Applied to 4.13/scsi-fixes. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
