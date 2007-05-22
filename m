Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 80B21DDE06
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 23:35:23 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <14B28267C4526A42BA5AC7DAA07B783866B7E7@zuk35exm20.fsl.freescale.net>
Subject: RE: Fixed PHY problems
Date: Tue, 22 May 2007 15:23:13 +0200
Message-ID: <1179840193.1468.10.camel@gentoo-jocke.transmode.se>
References: <14B28267C4526A42BA5AC7DAA07B783866B7E7@zuk35exm20.fsl.freescale.net>
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "Hammond Christian-r55079" <christian.hammond@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-05-21 at 13:46 +0100, Hammond Christian-r55079 wrote:
> Thanks,
>=20
> Regarding the PHY set-up in the dts once the patch has been applied, =
how
> should it be implemented?
>=20
> I had edited from...
>=20
> phy1:	ethernet-phy@01 {
> 		reg =3D <0>;
> 		device_type =3D "ethernet-phy";
> 		interface =3D <6>;
> 	};=20
>=20
> To...
>=20
> phy1:	fixed-phy@64 {
> 		reg =3D <d#100>;
> 		device_type =3D "ethernet-phy";
> 		interface =3D <6>;
> 	};
>=20
> When bringing up the fixed phy in ifconfig I get the following =
recurring
> dump and prompt access is lost. Should this implementation not just
> ignore the phy set-up?

Yes, but some bits are missing and I don't know OF/PHY lib/MDIO well
enough to make out what to do.

  Jocke
