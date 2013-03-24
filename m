Return-Path: <f.fainelli@gmail.com>
Received: from mail-wi0-x22b.google.com (mail-wi0-x22b.google.com
 [IPv6:2a00:1450:400c:c05::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 60C152C0085
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2013 07:48:42 +1100 (EST)
Received: by mail-wi0-f171.google.com with SMTP id hn17so9466900wib.10
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Mar 2013 13:48:38 -0700 (PDT)
Sender: Florian Fainelli <f.fainelli@gmail.com>
From: Florian Fainelli <florian@openwrt.org>
To: Simon Baatz <gmbnomis@gmail.com>
Subject: Re: [PATCH 0/2] Fix for mv643xx_eth built as module
Date: Sun, 24 Mar 2013 21:48:33 +0100
References: <1364157240-28883-1-git-send-email-gmbnomis@gmail.com>
In-Reply-To: <1364157240-28883-1-git-send-email-gmbnomis@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201303242148.33842.florian@openwrt.org>
Cc: thomas.petazzoni@free-electrons.com, andrew@lunn.ch, jason@lakedaemon.net,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Simon,

Le dimanche 24 mars 2013 21:33:58, Simon Baatz a =C3=A9crit :
> Recently [1], mv643xx_eth was changed to make use of mvmdio. However,
> this change introduces two problems when mvmdio and mv643xx_eth are
> built as modules:
>=20
> - mvmdio is not loaded automatically by udev
> - mv643xx_eth oopses when it can't find its PHY, i.e. when mvmdio is
>   not yet loaded
>=20
> The first problem can be fixed easily by adding a module alias for the
> respective platform device.  The proposed fix for the second problem
> uses EPROBE_DEFER as suggested by Thomas Petazzoni when the driver
> can't find its PHY.
>=20
> These patches apply on top of Florian Fainelli's patchset. They have
> been tested on Marvel Kirkwood non-DT.

Both fixes look good to me, thanks for fixing this!

Acked-by: Florian Fainelli <florian@openwrt.org>
=2D-=20
=46lorian
