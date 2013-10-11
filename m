Return-Path: <thomas@net.t-labs.tu-berlin.de>
Received: from mail.net.t-labs.tu-berlin.de (mail.net.t-labs.tu-berlin.de
 [IPv6:2001:470:96b9:4:130:149:220:252])
 by ozlabs.org (Postfix) with ESMTP id D72DE2C00E4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2013 19:59:40 +1100 (EST)
Received: from dai175.aot.tu-berlin.de (dai175.aot.tu-berlin.de
 [130.149.232.175])
 by mail.net.t-labs.tu-berlin.de (Postfix) with ESMTPSA id 657284C0502
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2013 10:59:34 +0200 (CEST)
From: =?iso-8859-1?Q?Thomas_H=FChn?= <thomas@net.t-labs.tu-berlin.de>
Content-Type: text/plain; charset=iso-8859-1
Subject: Fwd: Gianfar driver crashes in Kernel v3.10
Date: Fri, 11 Oct 2013 10:59:34 +0200
References: <90BE8C5D-E23B-41B5-BB52-8A0C0758931D@net.t-labs.tu-berlin.de>
To: linuxppc-dev@lists.ozlabs.org
Message-Id: <760FFC38-597B-46CB-BA4C-620A1D663C8A@net.t-labs.tu-berlin.de>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Claudiu,

> Does this show up on a half duplex (100Mb/s) link?

In my testsetup I always used 1GBit Ethernet connections, so no 100MBit =
tested yet.
Should I do so ?

> Could you provide following for the gianfar interface, on your setup:

sure:=20
> # ethtool ethX
root@Bluse-home:~# ethtool eth0
Settings for eth0:
       Supported ports: [ ]
       Supported link modes:   1000baseT/Full=20
       Supported pause frame use: No
       Supports auto-negotiation: No
       Advertised link modes:  1000baseT/Full=20
       Advertised pause frame use: No
       Advertised auto-negotiation: No
       Speed: 1000Mb/s
       Duplex: Full
       Port: MII
       PHYAD: 0
       Transceiver: external
       Auto-negotiation: on
       Current message level: 0x0000003f (63)
                              drv probe link timer ifdown ifup
       Link detected: yes

> and
> # ethtool -d ethX | grep 500
>=20
root@Bluse-home:~# ethtool -d eth0 | grep 500
0x0500:         00 00 00 3f 00 00 72 05 40 60 50 60 00 a1 f0 37=20


> Is there any other indication before this Oops? Like a tx timeout =
WARN?
>=20

Nothing there about any timeout.

Greetings Thomas

> Thanks,
> Claudiu
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
