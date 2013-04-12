Return-Path: <eric.dumazet@gmail.com>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
 [209.85.220.47])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 08A242C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 22:55:45 +1000 (EST)
Received: by mail-pa0-f47.google.com with SMTP id bj3so1445221pad.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 05:55:42 -0700 (PDT)
Message-ID: <1365771339.4459.0.camel@edumazet-glaptop>
Subject: Re: [PATCH v2] net: mv643xx_eth: remove deprecated inet_lro support
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Date: Fri, 12 Apr 2013 05:55:39 -0700
In-Reply-To: <1365758400-12565-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1365707488-28819-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1365758400-12565-1-git-send-email-sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Soeren Moch <smoch@web.de>, Paul Mackerras <paulus@samba.org>,
 linux-arm-kernel@lists.infradead.org, Dale Farnsworth <dale@farnsworth.org>,
 Ben Hutchings <bhutchings@solarflare.com>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Florian Fainelli <florian@openwrt.org>,
 Lennert Buytenhek <buytenh@wantstofly.org>, Willy Tarreau <w@1wt.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-04-12 at 11:20 +0200, Sebastian Hesselbarth wrote:
> With recent support for GRO, there is no need to keep both LRO and
> GRO. This patch therefore removes the deprecated inet_lro support
> from mv643xx_eth. This is work is based on an experimental patch
> provided by Eric Dumazet and Willy Tarreau.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Based-on-patch-by: Eric Dumazet <eric.dumazet@gmail.com>
> Based-on-patch-by: Willy Tarreau <w@1wt.eu>
> ---
> Changes from v1:
> - also remove INET_LRO from Kconfig (Reported by Eric Dumazet)

Thanks for finishing this patch

Signed-off-by: Eric Dumazet <edumazet@google.com>
