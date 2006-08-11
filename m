Return-Path: <Dai.Haruki@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 5F3E767BD9
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Aug 2006 04:12:32 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k7BICV4o007131 for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Aug 2006 11:12:31 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net
	[10.64.32.14])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k7BICUc0005229
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Aug 2006 13:12:30 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Gianfar eth driver on 8540 ppc - for 2.4 and 2.6 :
	differentoutputs
Date: Fri, 11 Aug 2006 11:08:59 -0700
Message-ID: <18AEF66AFDF06F4CAAA1D419D000FD3380B85B@az33exm24.fsl.freescale.net>
In-Reply-To: <CFF33627-951D-495D-8DBB-B0AC7F9D13D7@kernel.crashing.org>
From: "Haruki Dai-r35557" <Dai.Haruki@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>,
	"Prashant Yendigeri" <Prashant.Yendigeri@lntinfotech.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Why there are three TSEC on the MPC8540??=20

Dai

> -----Original Message-----
> From:=20
> linuxppc-embedded-bounces+dai.haruki=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-embedded-bounces+dai.haruki=3Dfreescale.com@ozl
> abs.org] On Behalf Of Kumar Gala
> Sent: Friday, August 11, 2006 7:38 AM
> To: Prashant Yendigeri
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: Gianfar eth driver on 8540 ppc - for 2.4 and 2.6=20
> : differentoutputs
>=20
>=20
> On Aug 11, 2006, at 6:21 AM, Prashant Yendigeri wrote:
>=20
> >
> > Hi,
> >
> > Downloaded 2.6.16.26 and booted up and got this :
> >
> > / # ifconfig eth0 172.28.8.254 up
> > [   34.034596] 0:00 not found
> > [   34.037330] eth0: Could not attach to PHY
> > [   34.041809] 0:00 not found
> > SIOCSIFFLAGS: No[   34.044526] eth0: Could not attach to PHY
> >  such device
> > SIOCSIFFLAGS: No such device
> >
> > I had enabled all the PHY devices in .config and also tried only =20
> > with Marvell phy enabled.
>=20
>=20
> Are you doing this on a custom board?  If so what is the PHY address =20
> for the Marvell phy you are using?
>=20
> - k
>=20
> >
> > Kernel boot messages :
> > [    2.296555] Gianfar MII Bus: probed
> > [    2.301789] eth0: Gianfar Ethernet Controller Version 1.2, =20
> > 00:01:af:07:9b:8a
> >
> > [    2.309039] eth0: Running with NAPI disabled
> > [    2.313307] eth0: 64/64 RX/TX BD ring size
> > [    2.318498] eth1: Gianfar Ethernet Controller Version 1.2, =20
> > 00:00:00:00:72:6f
> >
> > [    2.325738] eth1: Running with NAPI disabled
> > [    2.330006] eth1: 64/64 RX/TX BD ring size
> > [    2.335198] eth2: Gianfar Ethernet Controller Version 1.2, 6f:=20
> > 74:3d:2f:64:65
> >
> > [    2.342377] eth2: Running with NAPI disabled
> > [    2.346662] eth2: 64/64 RX/TX BD ring size
> > [    2.351586] Marvell 88E1101: Registered new driver
> > [    2.357010] Davicom DM9161E: Registered new driver
> > [    2.362443] Davicom DM9131: Registered new driver
> > [    2.367775] Cicada Cis8204: Registered new driver
> > [    2.373136] LXT970: Registered new driver
> > [    2.377794] LXT971: Registered new driver
> > [    2.382461] QS6612: Registered new driver
> >
> >
> > Regards,
> > Prashant
> >
> >
> >
> >
> >
> > Kumar Gala <galak@kernel.crashing.org>
> > 08/11/2006 09:40 AM
> >
> > To
> > Prashant Yendigeri <Prashant.Yendigeri@lntinfotech.com>
> > cc
> > linuxppc-embedded@ozlabs.org
> > Subject
> > Re: Gianfar eth driver on 8540 ppc - for 2.4 and 2.6 : different =20
> > outputs
> >
> >
> >
> >
> >
> >
> > On Aug 10, 2006, at 6:18 AM, Prashant Yendigeri wrote:
> >
> > >
> > > Hi,
> > >
> > > The gianfar driver of 2.6.12 and 2.4.20 give different outputs on
> > > the same PPC 8540 board.
> > >
> > > What could be the reason ?
> > >
> > > Output on 2.4.20 :
> > > /root # ifconfig eth0 172.28.8.254 up
> > > eth0: PHY is Marvell 88E1011S (1410c62)
> > > eth0: Auto-negotiation done
> > > eth0: Half Duplex
> > > eth0: Speed 10BT
> > > eth0: Link is up
> > >
> > > Output on 2.6.12
> > > / # ifconfig eth0 172.28.8.254 up
> > >  eth0: PHY is Generic MII (ffffffff)
> >
> > It looks like your 2.6.12 kernel isn't handling the PHY correctly.
> > I'd recommend upgrading to something newer which has the phylib
> > (can't remember which 2.6 that went into).
> >
> > - kumar
> >
> >=20
> ______________________________________________________________________
> >
> >
> >=20
> ______________________________________________________________________
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
