Return-Path: <sebastian.hesselbarth@gmail.com>
Received: from mail-bk0-x231.google.com (mail-bk0-x231.google.com
 [IPv6:2a00:1450:4008:c01::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E6DC02C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 05:53:00 +1000 (EST)
Received: by mail-bk0-f49.google.com with SMTP id w12so1027096bku.22
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 12:52:56 -0700 (PDT)
Message-ID: <51671494.6000803@gmail.com>
Date: Thu, 11 Apr 2013 21:52:52 +0200
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
MIME-Version: 1.0
To: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH] net: mv643xx_eth: remove deprecated inet_lro support
References: <1365707488-28819-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1365709617.3887.185.camel@edumazet-glaptop>
In-Reply-To: <1365709617.3887.185.camel@edumazet-glaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 04/11/2013 09:46 PM, Eric Dumazet wrote:
> On Thu, 2013-04-11 at 21:11 +0200, Sebastian Hesselbarth wrote:
>> With recent support for GRO, there is no need to keep both LRO and
>> GRO. This patch therefore removes the deprecated inet_lro support
>> from mv643xx_eth. This is work is based on an experimental patch
>> provided by Eric Dumazet and Willy Tarreau.
>>
>> Signed-off-by: Sebastian Hesselbarth<sebastian.hesselbarth@gmail.com>
>> Based-on-patch-by: Eric Dumazet<eric.dumazet@gmail.com>
>> Based-on-patch-by: Willy Tarreau<w@1wt.eu>
>> ---
>> Note: This patch is based upon recent cleanup patches and GRO support
>> patch for mv643xx_eth.
>>
>> Cc: "David S. Miller"<davem@davemloft.net>
>> Cc: Lennert Buytenhek<buytenh@wantstofly.org>
>> Cc: Andrew Lunn<andrew@lunn.ch>
>> Cc: Jason Cooper<jason@lakedaemon.net>
>> Cc: Florian Fainelli<florian@openwrt.org>
>> Cc: Benjamin Herrenschmidt<benh@kernel.crashing.org>
>> Cc: Paul Mackerras<paulus@samba.org>
>> Cc: Dale Farnsworth<dale@farnsworth.org>
>> Cc: Ben Hutchings<bhutchings@solarflare.com>
>> Cc: Soeren Moch<smoch@web.de>
>> Cc: Eric Dumazet<eric.dumazet@gmail.com>
>> Cc: Willy Tarreau<w@1wt.eu>
>> Cc: netdev@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>   drivers/net/ethernet/marvell/mv643xx_eth.c |   97 +---------------------------
>>   1 file changed, 3 insertions(+), 94 deletions(-)
>
> Seems fine to me, but you also could remove "select INET_LRO"
> from drivers/net/ethernet/marvell/Kconfig

Ok, I will wait for tomorrow to see if there are more objections and
respin a v2.

Sebastian
