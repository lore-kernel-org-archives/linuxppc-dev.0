Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E94D2B6FA3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Apr 2012 06:46:09 +1000 (EST)
Date: Sat, 21 Apr 2012 16:44:01 -0400 (EDT)
Message-Id: <20120421.164401.2058732185459124472.davem@davemloft.net>
To: b06378@freescale.com
Subject: Re: [PATCH] gianfar: add GRO support
From: David Miller <davem@davemloft.net>
In-Reply-To: <1334912075-27073-1-git-send-email-b06378@freescale.com>
References: <1334912075-27073-1-git-send-email-b06378@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jiajun Wu <b06378@freescale.com>
Date: Fri, 20 Apr 2012 16:54:35 +0800

> Replace netif_receive_skb with napi_gro_receive.
> 
> Signed-off-by: Jiajun Wu <b06378@freescale.com>

Applied.
