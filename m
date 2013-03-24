Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id E03BD2C0099
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2013 08:07:33 +1100 (EST)
Date: Sun, 24 Mar 2013 17:07:26 -0400 (EDT)
Message-Id: <20130324.170726.2271831814087007906.davem@davemloft.net>
To: florian@openwrt.org
Subject: Re: [PATCH 0/2] Fix for mv643xx_eth built as module
From: David Miller <davem@davemloft.net>
In-Reply-To: <201303242148.33842.florian@openwrt.org>
References: <1364157240-28883-1-git-send-email-gmbnomis@gmail.com>
 <201303242148.33842.florian@openwrt.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Cc: thomas.petazzoni@free-electrons.com, andrew@lunn.ch, gmbnomis@gmail.com,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, jason@lakedaemon.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Florian Fainelli <florian@openwrt.org>
Date: Sun, 24 Mar 2013 21:48:33 +0100

> Hello Simon,
> =

> Le dimanche 24 mars 2013 21:33:58, Simon Baatz a =E9crit :
>> Recently [1], mv643xx_eth was changed to make use of mvmdio. However=
,
>> this change introduces two problems when mvmdio and mv643xx_eth are
>> built as modules:
>> =

>> - mvmdio is not loaded automatically by udev
>> - mv643xx_eth oopses when it can't find its PHY, i.e. when mvmdio is=

>>   not yet loaded
>> =

>> The first problem can be fixed easily by adding a module alias for t=
he
>> respective platform device.  The proposed fix for the second problem=

>> uses EPROBE_DEFER as suggested by Thomas Petazzoni when the driver
>> can't find its PHY.
>> =

>> These patches apply on top of Florian Fainelli's patchset. They have=

>> been tested on Marvel Kirkwood non-DT.
> =

> Both fixes look good to me, thanks for fixing this!
> =

> Acked-by: Florian Fainelli <florian@openwrt.org>

All applied, thanks.
