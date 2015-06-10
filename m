Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 82BA41A02C2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 10:14:46 +1000 (AEST)
Date: Tue, 09 Jun 2015 17:14:41 -0700 (PDT)
Message-Id: <20150609.171441.861174213383180358.davem@davemloft.net>
To: alex.popov@linux.com
Cc: pantelis.antoniou@gmail.com, vbordug@ru.mvista.com,
 christophe.leroy@c-s.fr, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] net: fs_enet: Disable NETIF_F_SG feature for
 Freescale MPC5121
From: David Miller <davem@davemloft.net>
In-Reply-To: <1433894262-28900-1-git-send-email-alex.popov@linux.com>
References: <1433894262-28900-1-git-send-email-alex.popov@linux.com>
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

From: Alexander Popov <alex.popov@linux.com>
Date: Wed, 10 Jun 2015 02:57:42 +0300

> skb_copy_from_linear_data() which doesn't work well for non-linear sk_buff:

The correct fix is to use an SKB copy routine which can
handle non-linear data.
