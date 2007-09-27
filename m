Return-Path: <Joe.D'abbraccio@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 733BADDE05
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Sep 2007 05:42:05 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l8RJfxVG023464 for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Sep 2007 12:41:59 -0700 (MST)
Received: from az33exm20.fsl.freescale.net (az33exm20.am.freescale.net
	[10.64.32.6])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l8RJfwQL019772
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Sep 2007 14:41:59 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] Add platform support for the MPC837x RDB board
Date: Thu, 27 Sep 2007 12:41:57 -0700
Message-ID: <C908B0B881A6B949985D6BAA0D9469B402CD36A7@az33exm20.fsl.freescale.net>
In-Reply-To: <20070927191036.GD7838@mag.az.mvista.com>
References: <11909173512321-git-send-email-ljd015@freescale.com>
	<20070927191036.GD7838@mag.az.mvista.com>
From: "D'Abbraccio Joe-ljd015" <Joe.D'abbraccio@freescale.com>
To: "Mark A. Greer" <mgreer@mvista.com>
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

Thanks for the advice, but I was just basing the list to post to on the
MAINTAINERS file which states that this is the one for Embedded PPC83XX.
If you still think that I should post to linuxppc-dev, let me know.

> -----Original Message-----
> From: Mark A. Greer [mailto:mgreer@mvista.com]=20
> Sent: Thursday, September 27, 2007 3:11 PM
> To: D'Abbraccio Joe-ljd015
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: [PATCH] Add platform support for the MPC837x RDB board
>=20
> On Thu, Sep 27, 2007 at 02:22:31PM -0400, ljd015@freescale.com wrote:
> > From: Joe D'Abbraccio <ljd015@freescale.com>
> >=20
> > The MPC837x RDB is a new member of the Freescale MPC83xx reference=20
> > design boards.
>=20
> FYI, if you have patches for arch/powerpc, I recommend that=20
> you submit them to linuxppc-dev.  linuxppc-embedded is not=20
> monitored by many important people including paulus.
>=20
> Since these are 8xxx patches, chances are Kumar will see them=20
> and take them but you're still better off submitting to linuxppc-dev.
>=20
> Mark
>=20
