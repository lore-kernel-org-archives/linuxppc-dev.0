Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1D2591A0E70
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2016 18:16:15 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 20 Jan 2016 17:16:14 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id DC9993578058
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2016 18:16:12 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0K7G4uP43516152
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2016 18:16:12 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0K7FevR031496
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2016 18:15:40 +1100
Subject: Re: [PATCH 03/13] irq_poll: fold irq_poll_sched_prep into
 irq_poll_sched
To: Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bart.vanassche@sandisk.com>
References: <1449521512-22921-1-git-send-email-hch@lst.de>
 <1449521512-22921-4-git-send-email-hch@lst.de> <5682584A.5030708@sandisk.com>
 <20151230094253.GB12904@lst.de> <569F3106.7000205@au1.ibm.com>
Cc: linux-rdma@vger.kernel.org, sagig@dev.mellanox.co.il, axboe@fb.com,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <569F3403.10309@au1.ibm.com>
Date: Wed, 20 Jan 2016 18:15:15 +1100
MIME-Version: 1.0
In-Reply-To: <569F3106.7000205@au1.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 20/01/16 18:02, Andrew Donnellan wrote:
> I'm hitting an issue on a ppc64le box running linux-next, which
> according to git bisect is caused by this patch.

Whoops, that should be linuxppc*-dev*@lists.ozlabs.org in the Cc.


Andrew

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
