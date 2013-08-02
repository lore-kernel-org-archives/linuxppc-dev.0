Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id 46DE12C008F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Aug 2013 05:34:48 +1000 (EST)
Date: Fri, 02 Aug 2013 12:34:42 -0700 (PDT)
Message-Id: <20130802.123442.500196593983076682.davem@davemloft.net>
To: joe@perches.com
Subject: Re: [PATCH V3 0/3] networking: Use ETH_ALEN where appropriate
From: David Miller <davem@davemloft.net>
In-Reply-To: <cover.1375398692.git.joe@perches.com>
References: <20130801.143137.331385226409040561.davem@davemloft.net>
 <cover.1375398692.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: wimax@linuxwimax.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 netfilter-devel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Joe Perches <joe@perches.com>
Date: Thu,  1 Aug 2013 16:17:46 -0700

> Convert the uses mac addresses to ETH_ALEN so
> it's easier to find and verify where mac addresses
> need to be __aligned(2)

Series applied to net-next, thanks.
