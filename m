Return-Path: <jgg@mellanox.com>
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30067.outbound.protection.outlook.com [40.107.3.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 425CTc5xxzzF3Cj
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 04:51:16 +1000 (AEST)
Date: Wed, 5 Sep 2018 12:50:56 -0600
From: Jason Gunthorpe <jgg@mellanox.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Matteo Croce <mcroce@redhat.com>, Leon Romanovsky <leonro@mellanox.com>,
 linuxppc-dev@lists.ozlabs.org, op <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] tty: hvc: latency break regression fixes
Message-ID: <20180905185056.GF421@mellanox.com>
References: <20180905121439.23809-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180905121439.23809-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 05, 2018 at 10:14:36PM +1000, Nicholas Piggin wrote:
> Hi Greg,
> 
> Here are fixes for a few regressions that came in with my
> carelessness with the irq latency work for the hvc subsystem.
> These were independently reported in 2 configurations, and I
> confirmed with another.
> 
> I think those went upstream via Michael's tree, but he's away
> at the moment so if you would be able to consider them for
> the tty tree that would be appreciated.

Series works for me too, thanks.

Tested-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
