Return-Path: <thomas@net.t-labs.tu-berlin.de>
Received: from mail.net.t-labs.tu-berlin.de (mail.net.t-labs.tu-berlin.de
 [IPv6:2001:470:96b9:4:130:149:220:252])
 by ozlabs.org (Postfix) with ESMTP id A380B2C00CC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Oct 2013 23:44:12 +1100 (EST)
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: Gianfar driver crashes in Kernel v3.10
From: =?iso-8859-1?Q?Thomas_H=FChn?= <thomas@net.t-labs.tu-berlin.de>
In-Reply-To: <525E3BD7.1020208@freescale.com>
Date: Wed, 16 Oct 2013 14:44:03 +0200
Message-Id: <7EB7510D-8958-450B-BB63-429DC7F999D9@net.t-labs.tu-berlin.de>
References: <90BE8C5D-E23B-41B5-BB52-8A0C0758931D@net.t-labs.tu-berlin.de>
 <760FFC38-597B-46CB-BA4C-620A1D663C8A@net.t-labs.tu-berlin.de>
 <525E3BD7.1020208@freescale.com>
To: Claudiu Manoil <claudiu.manoil@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Together with other OpenWRT users we currently use this workaround patch =
(https://dev.openwrt.org/changeset/38409/trunk) that downgrades the =
gianfar driver to kernel version 3.9, as 3.10 is just crashing.=20
With this workaround, several users with TPLink 4900 routers reported =
that their system is runing stable and without issues.

>=20
> Please try the following patch:
> http://patchwork.ozlabs.org/patch/283235/
>=20
> It should help with your issue.
>=20

Thank for you patch.=20
I have adapted your patch to by applicable in current OpenWRT trunk.
I posted it in our current forum thread, where several users beside me =
will test it in the next days.
(https://forum.openwrt.org/viewtopic.php?pid=3D214931#p214931)
You can expect a report after the weekend.

Greetings Thomas

> claudiu
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
