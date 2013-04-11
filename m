Return-Path: <sebastian.hesselbarth@gmail.com>
Received: from mail-ea0-x232.google.com (mail-ea0-x232.google.com
 [IPv6:2a00:1450:4013:c01::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 338042C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 04:07:24 +1000 (EST)
Received: by mail-ea0-f178.google.com with SMTP id o10so896515eaj.37
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 11:07:20 -0700 (PDT)
Message-ID: <5166FBD4.5020508@gmail.com>
Date: Thu, 11 Apr 2013 20:07:16 +0200
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
MIME-Version: 1.0
To: Ben Hutchings <bhutchings@solarflare.com>
Subject: Re: [PATCH] net: mv643xx_eth: Add GRO support
References: <1365684023-9967-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1365702955.7355.5.camel@bwh-desktop.uk.solarflarecom.com>
In-Reply-To: <1365702955.7355.5.camel@bwh-desktop.uk.solarflarecom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Soeren Moch <smoch@web.de>, Paul Mackerras <paulus@samba.org>,
 linux-arm-kernel@lists.infradead.org, Dale Farnsworth <dale@farnsworth.org>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Florian Fainelli <florian@openwrt.org>,
 Lennert Buytenhek <buytenh@wantstofly.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/11/2013 07:55 PM, Ben Hutchings wrote:
> On Thu, 2013-04-11 at 14:40 +0200, Sebastian Hesselbarth wrote:
>> This patch adds GRO support to mv643xx_eth by making it invoke
>> napi_gro_receive instead of netif_receive_skb.
>
> The inet_lro support should be removed at the same time; inet_lro is now
> deprecated and there should be no need to keep both of them.

Ben,

I agree on removing it asap, but I also like to see GRO support
in. Maybe, we postpone lro removal just a little bit. I have just
started to look at mv643xx_eth and remember Marvell Orion SoCs are
not the only platform using it. I haven't heard a single word from
ppc guys, yet.

Willy just posted an experimental patch to remove lro. I'll have
a look at it and test it out on Dove.

Sebastian
