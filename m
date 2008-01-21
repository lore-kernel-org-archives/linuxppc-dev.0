Return-Path: <markus.mehlan@ritter-elektronik.de>
Received: from mail.textile.saurer.com (mail.schlafhorst.de [193.158.88.134])
	by ozlabs.org (Postfix) with ESMTP id 2CECADDE09
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 00:01:16 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: [MPC5200] problem running FEC and ATA
Date: Mon, 21 Jan 2008 14:01:14 +0100
Message-ID: <FACFFB02D783C64FB2CEF2D6825F6FC206EEF1C0@SRVEXC01.sts.saurer.vpn>
In-Reply-To: <200801210957.57761.jbe@pengutronix.de>
References: <FACFFB02D783C64FB2CEF2D6825F6FC206EEF1BE@SRVEXC01.sts.saurer.vpn>
	<200801210957.57761.jbe@pengutronix.de>
From: "Mehlan, Markus (Ritter Elektronik)" <markus.mehlan@ritter-elektronik.de>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 Hello Juergen,

> -----Urspr=FCngliche Nachricht-----
> Von: Juergen Beisert [mailto:jbe@pengutronix.de]=20
> Gesendet: Montag, 21. Januar 2008 09:58
> An: linuxppc-dev@ozlabs.org
> Cc: Mehlan, Markus (Ritter Elektronik)
> Betreff: Re: [MPC5200] problem running FEC and ATA
>=20
> Markus,
>=20
> On Monday 21 January 2008 08:10, Mehlan, Markus (Ritter=20
> Elektronik) wrote:
> > i have the same problem with the fec driver. See my posting at=20
> >=20
> http://ozlabs.org/pipermail/linuxppc-embedded/2008-January/029466.html
> >
> > Arnon, have you already fixed the FEC problem?
>=20
> Can you check this?
>=20
> http://ozlabs.org/pipermail/linuxppc-embedded/2007-May/027046.html

I have checked the article. To set the BSDIS bit in the XLB config =
register
during initialization fixes my problem:

xlb =3D (struct mpc52xx_xlb *)MPC5xxx_XLB;
out_be32(&xlb->config,  in_be32(&xlb->config) |
MPC52xx_XLB_CFG_BSDIS);

Thank you!

Best regards,
Markus
