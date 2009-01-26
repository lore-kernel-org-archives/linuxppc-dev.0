Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 4F26CDE100
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jan 2009 09:33:46 +1100 (EST)
Date: Mon, 26 Jan 2009 14:33:47 -0800 (PST)
Message-Id: <20090126.143347.147047233.davem@davemloft.net>
To: afleming@freescale.com
Subject: Re: [PATCH] gianfar: Revive VLAN support
From: David Miller <davem@davemloft.net>
In-Reply-To: <324701F1-4A84-41A6-BC2D-4A61A8E135D9@freescale.com>
References: <20090126205043.GA15581@oksana.dev.rtsoft.ru>
	<324701F1-4A84-41A6-BC2D-4A61A8E135D9@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Andy Fleming <afleming@freescale.com>
Date: Mon, 26 Jan 2009 15:07:37 -0600

> 
> On Jan 26, 2009, at 2:50 PM, Anton Vorontsov wrote:
> 
> > commit 77ecaf2d5a8bfd548eed3f05c1c2e6573d5de4ba ("gianfar: Fix VLAN
> > HW feature related frame/buffer size calculation") wrongly removed
> > priv->vlgrp assignment, and now priv->vlgrp is always NULL.
 ...
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> 
> Acked-by: Andy Fleming <afleming@freescale.com>

Applied, thanks guys.
