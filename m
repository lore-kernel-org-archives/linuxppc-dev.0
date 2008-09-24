Return-Path: <joakim.tjernlund@transmode.se>
Received: from mail.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id F340ADDF23
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 08:19:41 +1000 (EST)
From: "Joakim Tjernlund" <Joakim.Tjernlund@transmode.se>
To: "'David Brownell'" <david-b@pacbell.net>
References: <1219916613-28827-1-git-send-email-leoli@freescale.com>
	<0C69E0CDED15E4469A445DE244C1B9F708CEE6@zch01exm26.fsl.freescale.net>
	<1220343329.7762.23.camel@gentoo-jocke.transmode.se>
	<200809241328.35008.david-b@pacbell.net>
In-Reply-To: <200809241328.35008.david-b@pacbell.net>
Subject: RE: [PATCH] usb: add Freescale QE/CPM USB peripheral controllerdriver
Date: Wed, 24 Sep 2008 23:30:04 +0200
Message-ID: <07ab01c91e8c$b56f6140$204e23c0$@Tjernlund@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: greg@kroah.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, dbrownell@users.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: David Brownell [mailto:david-b@pacbell.net]
> Sent: den 24 september 2008 22:29
> To: joakim.tjernlund@transmode.se
> Cc: Li Yang-R58472; avorontsov@ru.mvista.com; greg@kroah.com; =
linux-usb@vger.kernel.org; linux-
> kernel@vger.kernel.org; dbrownell@users.sourceforge.net; =
linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] usb: add Freescale QE/CPM USB peripheral =
controllerdriver
>=20
> On Tuesday 02 September 2008, Joakim Tjernlund wrote:
> >
> > > Noted: =A0AFAIK, RNDIS gadget in Linux doesn't interoperate with =
windows
> > > well enough to be production level. =A0Use at your own risk.
> >
> > I see. If one wants to connect with CDC to Windows, what drivers are
> > there for Windows that works well with Linux?
>=20
> I believe MCCI has some.  It also has drivers for a CDC subset,
> pretty much the same one Linux has used forever except wrapped
> with a few extra descriptors to make it practical to identify
> that "SAFE" (!) subset without needing vendor and product IDs.

Thanks, had a look and it seems like I have to buy these drives. I was
hoping to find some free ones, do you know of such free drivers?

 Jocke=20
