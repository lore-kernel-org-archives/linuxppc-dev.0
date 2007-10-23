Return-Path: <axboe@kernel.dk>
Received: from kernel.dk (brick.kernel.dk [87.55.233.238])
	by ozlabs.org (Postfix) with ESMTP id DA0DFDDE30
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 15:05:16 +1000 (EST)
Date: Tue, 23 Oct 2007 07:05:12 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re: IB/ehca: Fix sg_page() fallout
Message-ID: <20071023050512.GK16425@kernel.dk>
References: <1193076664-13652-1-git-send-email-jens.axboe@oracle.com>
	<1193076664-13652-10-git-send-email-jens.axboe@oracle.com>
	<20071023040948.GA19699@lixom.net>
	<20071023043148.GA20904@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071023043148.GA20904@lixom.net>
Cc: linuxppc-dev@ozlabs.org, Joachim Fenkes <fenkes@de.ibm.com>,
	torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 22 2007, Olof Johansson wrote:
> More fallout from sg_page changes, found with powerpc allyesconfig:
> 
> drivers/infiniband/hw/ehca/ehca_mrmw.c: In function 'ehca_set_pagebuf_user1':
> drivers/infiniband/hw/ehca/ehca_mrmw.c:1779: error: 'struct scatterlist' has no member named 'page'
> drivers/infiniband/hw/ehca/ehca_mrmw.c: In function 'ehca_check_kpages_per_ate':
> drivers/infiniband/hw/ehca/ehca_mrmw.c:1835: error: 'struct scatterlist' has no member named 'page'
> drivers/infiniband/hw/ehca/ehca_mrmw.c: In function 'ehca_set_pagebuf_user2':
> drivers/infiniband/hw/ehca/ehca_mrmw.c:1870: error: 'struct scatterlist' has no member named 'page'

Thanks a lot Olof, applied both fixups!

-- 
Jens Axboe
