Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [149.20.54.216])
 by lists.ozlabs.org (Postfix) with ESMTP id 3rPxJq1VT4zDqxW
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 04:08:58 +1000 (AEST)
Date: Wed, 08 Jun 2016 11:08:41 -0700 (PDT)
Message-Id: <20160608.110841.1742678705562218191.davem@davemloft.net>
To: andreas.ziegler@fau.de
Cc: qiang.zhao@nxp.com, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, valentinrothberg@gmail.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/net/fsl_ucc: Do not prefix header guard with
 CONFIG_
From: David Miller <davem@davemloft.net>
In-Reply-To: <1465378828-7077-1-git-send-email-andreas.ziegler@fau.de>
References: <1465378828-7077-1-git-send-email-andreas.ziegler@fau.de>
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

From: Andreas Ziegler <andreas.ziegler@fau.de>
Date: Wed,  8 Jun 2016 11:40:28 +0200

> The CONFIG_ prefix should only be used for options which
> can be configured through Kconfig and not for guarding headers.
> 
> Signed-off-by: Andreas Ziegler <andreas.ziegler@fau.de>

Applied.
