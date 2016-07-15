Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3rrhKD1rKFzDr0N
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jul 2016 04:43:11 +1000 (AEST)
Date: Fri, 15 Jul 2016 11:43:08 -0700 (PDT)
Message-Id: <20160715.114308.1901247006216834380.davem@davemloft.net>
To: dan.carpenter@oracle.com
Cc: qiang.zhao@nxp.com, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
 wharms@bfs.de
Subject: Re: [patch v2 -next] wan/fsl_ucc_hdlc: info leak in uhdlc_ioctl()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20160714111653.GA30452@mwanda>
References: <57876EE0.10603@bfs.de>
	<20160714111653.GA30452@mwanda>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 14 Jul 2016 14:16:53 +0300

> There is a 2 byte struct whole after line.loopback so we need to clear
> that out to avoid disclosing stack information.
> 
> Fixes: c19b6d246a35 ('drivers/net: support hdlc function for QE-UCC')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2: remove the other initialization to zero

Applied.
