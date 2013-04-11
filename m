Return-Path: <eric.dumazet@gmail.com>
Received: from mail-pb0-f41.google.com (mail-pb0-f41.google.com
 [209.85.160.41])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 054BF2C00C6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 03:59:20 +1000 (EST)
Received: by mail-pb0-f41.google.com with SMTP id mc17so986527pbc.14
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 10:59:18 -0700 (PDT)
Message-ID: <1365703155.3887.184.camel@edumazet-glaptop>
Subject: Re: [PATCH] net: mv643xx_eth: Add GRO support
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Willy Tarreau <w@1wt.eu>
Date: Thu, 11 Apr 2013 10:59:15 -0700
In-Reply-To: <20130411175147.GN1910@1wt.eu>
References: <CABJ1b_TQDabT1J7ffo5cb1Th=71bcSduifMJaDpfVRiiHvtWDw@mail.gmail.com>
 <20130411150326.GA19978@1wt.eu>
 <CABJ1b_TRxm97DKJLP_h0VwMJvcYmSpjoJvtg1KvBNGah=VzqMQ@mail.gmail.com>
 <20130411.133119.913809939413807690.davem@davemloft.net>
 <20130411175147.GN1910@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: andrew@lunn.ch, jason@lakedaemon.net, linux-kernel@vger.kernel.org,
 florian@openwrt.org, smoch@web.de, paulus@samba.org,
 linux-arm-kernel@lists.infradead.org, dale@farnsworth.org,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>, buytenh@wantstofly.org,
 sebastian.hesselbarth@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-04-11 at 19:51 +0200, Willy Tarreau wrote:

> Eric provided me with one such experimental patch in the past for this
> driver. It worked for me but we never tried to clean it up to propose
> it for inclusion.
> 
> If anyone is interested, I might still have it in experimental shape.

We are interested a lot ;)

Thanks !
