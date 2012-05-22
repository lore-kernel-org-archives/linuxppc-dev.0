Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5589BB6F9D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2012 05:20:35 +1000 (EST)
Date: Tue, 22 May 2012 15:18:30 -0400 (EDT)
Message-Id: <20120522.151830.2018953337014839778.davem@davemloft.net>
To: b06378@freescale.com
Subject: Re: [PATCH] gianfar:don't add FCB length to hard_header_len
From: David Miller <davem@davemloft.net>
In-Reply-To: <1337677248-27792-1-git-send-email-b06378@freescale.com>
References: <1337677248-27792-1-git-send-email-b06378@freescale.com>
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
Date: Tue, 22 May 2012 17:00:48 +0800

> FCB(Frame Control Block) isn't the part of netdev hard header.
> Add FCB to hard_header_len will make GRO fail at MAC comparision stage.
> 
> Signed-off-by: Jiajun Wu <b06378@freescale.com>

Applied, thanks.

Someone needs to go through this driver when net-next opens up
and fix all of the indentation in this driver.
