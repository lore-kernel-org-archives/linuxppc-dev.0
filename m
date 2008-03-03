Return-Path: <carcadiz@hotmail.com>
Received: from blu139-omc3-s10.blu139.hotmail.com
	(blu139-omc3-s10.blu139.hotmail.com [65.55.175.210])
	by ozlabs.org (Postfix) with ESMTP id 9184DDDF05
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Mar 2008 00:05:44 +1100 (EST)
Message-ID: <BLU106-W22AC7D9FCF4035AF6AB5E6CA170@phx.gbl>
From: "Pedro Luis D. L." <carcadiz@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE: I2S driver
Date: Mon, 3 Mar 2008 14:05:42 +0100
In-Reply-To: <529490.33431.qm@web23110.mail.ird.yahoo.com>
References: <529490.33431.qm@web23110.mail.ird.yahoo.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Angelo wrote:
=20
> Hi my name is Angelo.
>=20
> I'm working on I2S driver, on MPC5200b board.
> Does anyone tell me where i can found some information on HOW to write it=
?
>=20
> Thanks for help.
>=20


Hello Angelo,
depends on which kernel version are you using. You can find some working co=
de in DENX repository:
http://source.denx.net/cgi-bin/gitweb.cgi
=20
I can also send you some GPL'd code that works. It is extremely bad comment=
ed (:-p) and probably not useful (it's not an ALSA driver itself, but it us=
es the DMA to copy data to the PSC - I2S mode) but it works. But this code =
is based on 2.6.16 kernel.

Tell me the version and I would guide you a little bit.
=20
Regards,
Pedro.

_________________________________________________________________
MSN Video.=20
http://video.msn.com/?mkt=3Des-es=
