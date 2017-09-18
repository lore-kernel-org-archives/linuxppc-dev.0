Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xwqvB6PfMzDrX7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 01:39:50 +1000 (AEST)
Date: Mon, 18 Sep 2017 17:39:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-xfs <linux-xfs@vger.kernel.org>,
 linux-next <linux-next@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 chandan <chandan@linux.vnet.ibm.com>
Subject: Re: [linux-next][XFS][trinity] WARNING: CPU: 32 PID: 31369 at
 fs/iomap.c:993
Message-ID: <20170918153947.GA12635@lst.de>
References: <1505746565.6990.18.camel@abdul.in.ibm.com>
 <20170918152706.GA11482@lst.de>
 <8abed401-1634-760f-6543-4652fa495315@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8abed401-1634-760f-6543-4652fa495315@kernel.dk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 18, 2017 at 09:28:55AM -0600, Jens Axboe wrote:
> If it's expected, why don't we kill the WARN_ON_ONCE()? I get it all
> the time running xfstests as well.

Dave insisted on it to decourage users/applications from mixing
mmap and direct I/O.

In many ways a tracepoint might be the better way to diagnose these.
