Return-Path: <LeoLi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: UCC GETH does not work on my MPC8360EA 
Date: Wed, 17 Sep 2008 17:38:39 +0800
Message-ID: <113760FDF39C3E40AAB8DE6E6C64D0A7110901@zch01exm26.fsl.freescale.net>
In-Reply-To: <48D0CB3C.7050708@grandegger.com>
References: <48D0CB3C.7050708@grandegger.com>
From: "Li Yang-R58472" <LeoLi@freescale.com>
To: "Wolfgang Grandegger" <wg@grandegger.com>,
	"linuxppc-dev" <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org]=20
> On Behalf Of Wolfgang Grandegger
> Sent: Wednesday, September 17, 2008 5:18 PM
> To: linuxppc-dev
> Subject: UCC GETH does not work on my MPC8360EA=20
>=20
> Hello,
>=20
> I have a wired problems with my MPC8360EA using Linux=20
> 2.6.27-rc6. The UCC GEHT controller works fine with 100/Full=20
> but fails with 1000/Full.
> What I see is that the TX done interrupts come (ifconfig's TX=20
> packet counter goes up), but the messages does not show up on=20
> the wire. RX seems to work properly, though.
>=20
> Any idea what's going wrong? Does someone got it working with=20
> 1000/Full?

This looks like an old problem that RGMII Tx shouldn't use internal
delay while Rx should use.  So try to use 'rgmii-rxid' as
phy-connection-type in device tree.  Also there should have been a fixup
in u-boot for this.  So update to use latest u-boot might fix your
problem.

- Leo
