Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 640BB1A01E5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jul 2014 14:31:06 +1000 (EST)
Date: Sun, 20 Jul 2014 21:31:02 -0700 (PDT)
Message-Id: <20140720.213102.1007291311502673484.davem@davemloft.net>
To: fabf@skynet.be
Subject: Re: [PATCH 00/30] drivers/net: remove unnecessary break after return
From: David Miller <davem@davemloft.net>
In-Reply-To: <1405865801-18806-1-git-send-email-fabf@skynet.be>
References: <1405865801-18806-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: brcm80211-dev-list@broadcom.com, e1000-devel@lists.sourceforge.net,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, joe@perches.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Fabian Frederick <fabf@skynet.be>
Date: Sun, 20 Jul 2014 16:16:08 +0200

> Second patchset after "remove unnecessary break after goto" addressing break redundancy on drivers/net branch
> (suggested by Joe Perches)

All applied except the i40e patch, which did not apply to net-next at all.
