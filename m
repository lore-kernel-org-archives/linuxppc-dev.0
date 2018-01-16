Return-Path: <madalin.bucur@nxp.com>
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20062.outbound.protection.outlook.com [40.107.2.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLc9X5sCZzF0V5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 04:07:59 +1100 (AEDT)
From: Madalin-cristian Bucur <madalin.bucur@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>, mad skateman <madskateman@gmail.com>
CC: Christian Zigotzky <chzigotzky@xenosoft.de>, Joakim Tjernlund
 <Joakim.Tjernlund@infinera.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: RE: DPAA Ethernet traffice troubles with Linux kernel
Date: Tue, 16 Jan 2018 17:07:53 +0000
Message-ID: <DB3PR0402MB38499A06FE30E2A2D67D9569ECEA0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
References: <CAHkrCmFCzPd_a1UmyfuZHKM4hXvou0uO0FYoG5bd_fxE8QMueg@mail.gmail.com>
 <DB3PR0402MB3849EEF00D71FF7A230B70C3ECEB0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <1516035556.18795.71.camel@infinera.com>
 <346361be-ce30-6a13-c154-5192d2668723@xenosoft.de>
 <32f11c91-9529-180a-a8cf-9f380f853b99@xenosoft.de>
 <CAHkrCmFwMRh7+9ijRhgpqm_dQmE7uH8pv8ZQvLY1rxk1hjhfzw@mail.gmail.com>
 <20180116150411.GG22903@lunn.ch>
In-Reply-To: <20180116150411.GG22903@lunn.ch>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: netdev-owner@vger.kernel.org [mailto:netdev-owner@vger.kernel.org]
> On Behalf Of Andrew Lunn
> Sent: Tuesday, January 16, 2018 5:04 PM
> To: mad skateman <madskateman@gmail.com>
> Cc: Christian Zigotzky <chzigotzky@xenosoft.de>; Joakim Tjernlund
> <Joakim.Tjernlund@infinera.com>; linuxppc-dev@lists.ozlabs.org; Madalin-
> cristian Bucur <madalin.bucur@nxp.com>; netdev@vger.kernel.org
> Subject: Re: DPAA Ethernet traffice troubles with Linux kernel
>=20
> > When i use mii-tool too Kick the tranceiver... it comes alive.. i can
> > ping the eth0 itself
> >
> > root@X5000LNX:/home/skateman# mii-tool -R eth0
> > resetting the transceiver...
> > root@X5000LNX:/home/skateman# ping 192.168.22.44
> > PING 192.168.22.44 (192.168.22.44) 56(84) bytes of data.
> > 64 bytes from 192.168.22.44: icmp_seq=3D1 ttl=3D64 time=3D0.045 ms
> > 64 bytes from 192.168.22.44: icmp_seq=3D2 ttl=3D64 time=3D0.046 ms
> > 64 bytes from 192.168.22.44: icmp_seq=3D3 ttl=3D64 time=3D0.047 ms
> > 64 bytes from 192.168.22.44: icmp_seq=3D4 ttl=3D64 time=3D0.048 ms
>=20
> What PHY driver are you using?
>=20
> This smells a bit like an RGMII-ID problem.
>=20
>      Andrew

Hi Andrew,

>From another thread[1] on the same topic:

> I am not sure what PHY hardware/configuration you are using on the
> DS and RDB platforms, but I can confirm that AmigaONE X5000/20
> (Cyrus Motherboard with p5020 SoC), has dTSEC 4 and dTSEC 5
> wired to two Micrel KSZ9021RN Gigabit Ethernet PHYs, using the
> RGMII protocol.

[1] https://www.spinics.net/lists/netdev/msg478062.html
