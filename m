Return-Path: <scott.coulter@cyclone.com>
Received: from CYBORG3.cyclone.com (cyborg3.cyclone.com [69.37.28.78])
	by ozlabs.org (Postfix) with ESMTP id E7490DDE20
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Feb 2009 07:59:46 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Gianfar tx-babbling-errors
Date: Fri, 20 Feb 2009 15:59:40 -0500
Message-ID: <43EB80E07C42E1408726E4905FB96B04C0774E@CYBORG3.cyclone.com>
In-Reply-To: <18AEF66AFDF06F4CAAA1D419D000FD3302B1EAB1@az33exm24.fsl.freescale.net>
References: <43EB80E07C42E1408726E4905FB96B04C0769D@CYBORG3.cyclone.com>
	<18AEF66AFDF06F4CAAA1D419D000FD3302B1EAB1@az33exm24.fsl.freescale.net>
From: "Scott Coulter" <scott.coulter@cyclone.com>
To: "Haruki Dai-R35557" <Dai.Haruki@freescale.com>, <linuxppc-dev@ozlabs.org>
Cc: Gala Kumar-B11780 <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>




Dai,

>  Is this your own board? If so, what PHY chip are you using? Are you
> using the PHY driver?
>  If the generic PHY driver is used and polling the MDIO periodically
for
> the link check, you may truncate the packet. I hope this is not the
> case.

Yes this is our own board.  Both the 8568E and 8572E processors each
expose two TSECs.  The 4 TSECs are each connected to a separate
interface of a  Broadcom 5464 Quad PHY in RGMII mode.  I am pretty sure
that there is no interrupt connected (I'll have to check with the
hardware engineer) and I know that I didn't configure one in the DTS
file.  My kernel is configured to use the Broadcomm 54xx driver, but I'm
not sure if it polls when no interrupt is configured.

Thanks,
Scott
___________________________________________________________________

  Scott N. Coulter
  Senior Software Engineer
 =20
  Cyclone Microsystems         =20
  370 James Street              Phone:  203.786.5536 ext. 118
  New Haven, CT 06513-3051      Email:  scott.coulter@cyclone.com
  U.S.A.                        Web:    http://www.cyclone.com
___________________________________________________________________

> -----Original Message-----
> From: Haruki Dai-R35557 [mailto:Dai.Haruki@freescale.com]
> Sent: February 20, 2009 2:16PM
> To: Scott Coulter; linuxppc-dev@ozlabs.org
> Cc: Gala Kumar-B11780
> Subject: RE: Gianfar tx-babbling-errors
>=20
> Hi Scott,
>=20
>=20
> Regards
> Dai
>=20
> > -----Original Message-----
> > From: linuxppc-dev-bounces+dai.haruki=3Dfreescale.com@ozlabs.org
> > [mailto:linuxppc-dev-bounces+dai.haruki=3Dfreescale.com@ozlabs.org] =
On
> Behalf Of
> > Scott Coulter
> > Sent: Wednesday, February 18, 2009 10:16 AM
> > To: linuxppc-dev@ozlabs.org
> > Subject: Gianfar tx-babbling-errors
> >
> >
> > Hi all,
> >
> > As a simple stress test for my board with an MPC8572E and an
MPC8568E
> on
> > it, I setup both processors to boot linux 2.6.27.6 with an NFS root
> and
> > then perform repeated native compiles of a linux kernel over NFS.
> After
> > running for 4 days straight or so with between 250-300 build cycles
> per
> > processor, I stopped the builds and ran ethtool to look for any odd
> > statistics.  Both processors reported non-zero values for
> > tx-babbling-errors.  Both processors reported around 1300
> > tx-babbling-errors out of about 80,000,000 Tx packets.  Should I be
> > concerned about the tx-babbling-errors?  What conditions would cause
> > these errors to be reported?
> >
> > Thanks,
> > Scott
> >
> >
> >
> >
> >
> > ___________________________________________________________________
> >
> >   Scott N. Coulter
> >   Senior Software Engineer
> >
> >   Cyclone Microsystems
> >   370 James Street              Phone:  203.786.5536 ext. 118
> >   New Haven, CT 06513-3051      Email:  scott.coulter@cyclone.com
> >   U.S.A.                        Web:    http://www.cyclone.com
> > ___________________________________________________________________
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
