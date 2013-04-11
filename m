Return-Path: <eric.dumazet@gmail.com>
Received: from mail-ia0-x22a.google.com (mail-ia0-x22a.google.com
 [IPv6:2607:f8b0:4001:c02::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A60AA2C00BB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 03:35:30 +1000 (EST)
Received: by mail-ia0-f170.google.com with SMTP id j38so1658588iad.15
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 10:35:27 -0700 (PDT)
Message-ID: <1365701725.3887.177.camel@edumazet-glaptop>
Subject: Re: [PATCH] net: mv643xx_eth: Add GRO support
From: Eric Dumazet <eric.dumazet@gmail.com>
To: David Miller <davem@davemloft.net>
Date: Thu, 11 Apr 2013 10:35:25 -0700
In-Reply-To: <20130411.133119.913809939413807690.davem@davemloft.net>
References: <CABJ1b_TQDabT1J7ffo5cb1Th=71bcSduifMJaDpfVRiiHvtWDw@mail.gmail.com>
 <20130411150326.GA19978@1wt.eu>
 <CABJ1b_TRxm97DKJLP_h0VwMJvcYmSpjoJvtg1KvBNGah=VzqMQ@mail.gmail.com>
 <20130411.133119.913809939413807690.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: andrew@lunn.ch, jason@lakedaemon.net, linux-kernel@vger.kernel.org,
 florian@openwrt.org, smoch@web.de, paulus@samba.org,
 linux-arm-kernel@lists.infradead.org, dale@farnsworth.org,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, w@1wt.eu,
 buytenh@wantstofly.org, sebastian.hesselbarth@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-04-11 at 13:31 -0400, David Miller wrote:

> I think, as per other drivers, LRO should be eliminated completely from
> all drivers, including this one, and GRO used exclusively instead.

This would be awesome.

AFAIK current LRO users are :

drivers/infiniband/hw/nes/nes_hw.c
drivers/net/ethernet/marvell/mv643xx_eth.c
drivers/net/ethernet/pasemi/pasemi_mac.c
