Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wMYTt62HszDqNM
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 May 2017 19:09:38 +1000 (AEST)
Date: Tue, 9 May 2017 11:03:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 linux-block <linux-block@vger.kernel.org>,
 sachinp <sachinp@linux.vnet.ibm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>
Subject: Re: [linux-next][bock] WARNING: CPU: 22 PID: 0 at
 block/blk-core.c:2655 .blk_update_request+0x4f8/0x500
Message-ID: <20170509090316.GA2378@lst.de>
References: <1493965539.7355.44.camel@abdul.in.ibm.com>
 <15a0a50a-d57d-736b-634c-4d0131ec5af3@kernel.dk>
 <1494227599.2983.2.camel@abdul.in.ibm.com>
 <f1a1ced1-6f3c-8fec-2e2d-4db4c09e31fc@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f1a1ced1-6f3c-8fec-2e2d-4db4c09e31fc@kernel.dk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 08, 2017 at 08:00:41AM -0600, Jens Axboe wrote:
> Christoph, Martin - any ideas? Trace from Abdul below.

Btw, what page size does the system have?

> 
> WARNING: CPU: 12 PID: 0 at block/blk-core.c:2651 .blk_update_request+0x4cc/0x4e0

Any knowledge from tracing or printk on what command is complete?
Both req_op type and SCSI command?
