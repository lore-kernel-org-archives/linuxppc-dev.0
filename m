Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id 1C5DE2C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 07:05:26 +1000 (EST)
Date: Wed, 02 Oct 2013 17:05:21 -0400 (EDT)
Message-Id: <20131002.170521.463969346066312216.davem@davemloft.net>
To: joe@perches.com
Subject: Re: [PATCH net-next] net:drivers/net: Miscellaneous conversions to
 ETH_ALEN
From: David Miller <davem@davemloft.net>
In-Reply-To: <1380679480.2081.24.camel@joe-AO722>
References: <1380679480.2081.24.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: brcm80211-dev-list@broadcom.com, bridge@lists.linux-foundation.org,
 e1000-devel@lists.sourceforge.net, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, ath10k@lists.infradead.org,
 wil6210@qca.qualcomm.com, netfilter-devel@vger.kernel.org,
 b43-dev@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Joe Perches <joe@perches.com>
Date: Tue, 01 Oct 2013 19:04:40 -0700

> Convert the memset/memcpy uses of 6 to ETH_ALEN
> where appropriate.
> 
> Also convert some struct definitions and u8 array
> declarations of [6] to ETH_ALEN.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Looks fine, applied, thanks Joe.
