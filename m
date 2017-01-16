Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3v2MfJ4J5mzDqQG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 05:47:04 +1100 (AEDT)
Date: Mon, 16 Jan 2017 13:47:01 -0500 (EST)
Message-Id: <20170116.134701.1316974977589117728.davem@davemloft.net>
To: bhumirks@gmail.com
Cc: julia.lawall@lip6.fr, pantelis.antoniou@gmail.com,
 vbordug@ru.mvista.com, sergei.shtylyov@cogentembedded.com,
 f.fainelli@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] net: constify mdiobb_ops structures
From: David Miller <davem@davemloft.net>
In-Reply-To: <1484330546-16569-1-git-send-email-bhumirks@gmail.com>
References: <1484330546-16569-1-git-send-email-bhumirks@gmail.com>
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

From: Bhumika Goyal <bhumirks@gmail.com>
Date: Fri, 13 Jan 2017 23:32:26 +0530

> Declare mdiobb_ops structures as const as they are only stored in the
> ops field of mdiobb_ctrl structures. This field is of type const, so
> mdiobb_ops structures having this property can be declared const too.

This patch doesn't apply cleanly to net-next, please respin.
