Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F0841B7008
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2012 07:48:49 +1100 (EST)
Date: Mon, 19 Mar 2012 16:46:42 -0400 (EDT)
Message-Id: <20120319.164642.1200863018458579196.davem@davemloft.net>
To: paul.gortmaker@windriver.com
Subject: Re: [PATCH v2 net-next 0/4] Gianfar byte queue limits
From: David Miller <davem@davemloft.net>
In-Reply-To: <1332106761-18293-1-git-send-email-paul.gortmaker@windriver.com>
References: <1332089787-24086-1-git-send-email-paul.gortmaker@windriver.com>
 <1332106761-18293-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 eric.dumazet@gmail.com, therbert@google.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Sun, 18 Mar 2012 17:39:17 -0400

> The following changes since commit cdf485be3a63d1f34293740fb726088c6840ceea:
> 
>   ixgbe: dcb: use DCB config values for FCoE traffic class on open (2012-03-14 00:49:10 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/paulg/linux.git gianfar-bql
> 
> for you to fetch changes up to 5407b14c6792d6ff122ecb1a2a6acffad60ef389:
> 
>   gianfar: use netif_tx_queue_stopped instead of __netif_subqueue_stopped (2012-03-18 17:11:22 -0400)

Pulled, thanks.
