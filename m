Return-Path: <axboe@kernel.dk>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6DEA7B6F9F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2012 21:37:59 +1100 (EST)
Message-ID: <4F588BDE.3080503@kernel.dk>
Date: Thu, 08 Mar 2012 11:37:18 +0100
From: Jens Axboe <axboe@kernel.dk>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 0/7] powerpc: remove the legacy iSeries platform specific
 drivers
References: <20120308152853.b5010336abbb8f90e8a2500c@canb.auug.org.au>
In-Reply-To: <20120308152853.b5010336abbb8f90e8a2500c@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-scsi@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "James E.J. Bottomley" <JBottomley@parallels.com>,
 linux-serial@vger.kernel.org, netdev@vger.kernel.org,
 Brian King <brking@linux.vnet.ibm.com>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, David Miller <davem@davemloft.net>,
 Alan Cox <alan@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/08/2012 05:28 AM, Stephen Rothwell wrote:
> It would probably be easiest if all these patches were merged via the
> powerpc tree to eliminate any dependencies between them.  Their impact on
> generic code is very small.

Go ahead, no point in doing otherwise.

-- 
Jens Axboe
