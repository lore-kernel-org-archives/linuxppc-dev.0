Return-Path: <w-lkml@lebenslange-mailadresse.de>
Received: from mail0.toppoint.de (mail0.toppoint.de [217.70.197.20])
 by ozlabs.org (Postfix) with ESMTP id 42E4D14009B
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 May 2014 22:49:53 +1000 (EST)
Date: Sun, 11 May 2014 12:46:34 +0000
From: Wilfried Klaebe <w-lkml@lebenslange-mailadresse.de>
To: Anish Khurana <anish.khurana130181@gmail.com>
Subject: Re: [PATCH] [resend] net: get rid of SET_ETHTOOL_OPS
Message-ID: <20140511124633.GD7875@kaos.lebenslange-mailadresse.de>
References: <20140511001231.GC7875@kaos.lebenslange-mailadresse.de>
 <CANKiNjV7qrx-556DJk0qcOopnBs4NnKy51POEeZ7LpbdjX35OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANKiNjV7qrx-556DJk0qcOopnBs4NnKy51POEeZ7LpbdjX35OQ@mail.gmail.com>
Cc: devel@driverdev.osuosl.org, linux-s390@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, dev@openvswitch.org,
 xen-devel@lists.xenproject.org, linux-rdma@vger.kernel.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-acenic@sunsite.dk, trivial@kernel.org, e1000-devel@lists.sourceforge.net,
 bridge@lists.linux-foundation.org, devel@linuxdriverproject.org,
 nios2-dev@lists.rocketboards.org, virtualization@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Sun, May 11, 2014 at 01:13:47PM +0530 schrieb Anish Khurana:
> SET_ETHTOOL_OPS is equivalent to :
> #define SET_ETHTOOL_OPS(netdev,ops) \
>     ( (netdev)->ethtool_ops =3D (ops) )
>=20
> how it makes difference  removing this code and replacing with the
> code mentioned ?

It doesn't change anything in the resulting binaries. The whole point
is to remove the macro, which is something Dave wants to happen.

Kind regards,
Wilfried
