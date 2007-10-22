Return-Path: <Emilian.Medve@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 25EA1DDE1B
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 23:47:40 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l9MDlYqb027529
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 06:47:34 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net
	[10.64.32.14])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l9MDlXWG000569
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 08:47:34 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] [POWERPC] ucc_geth: Eliminate compile warnings
Date: Mon, 22 Oct 2007 06:47:32 -0700
Message-ID: <598D5675D34BE349929AF5EDE9B03E2701685446@az33exm24.fsl.freescale.net>
In-Reply-To: <20071019.164143.75786621.davem@davemloft.net>
References: <1192745713-20829-1-git-send-email-Emilian.Medve@Freescale.com><20071018.173032.48505868.davem@davemloft.net><598D5675D34BE349929AF5EDE9B03E270168520B@az33exm24.fsl.freescale.net>
	<20071019.164143.75786621.davem@davemloft.net>
From: "Medve Emilian-EMMEDVE1" <Emilian.Medve@freescale.com>
To: "David Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, jgarzik@pobox.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello David,


> No piece of code in the kernel should live in a vacuum.
>=20
> In order to improve overall code quality, every piece of
> driver code should avoid assuming things about pointer
> sizes and things of this nature.

I'm afraid we might be talking about orthogonal issues here. I actively
agree that all code (not only kernel) should be written up to the
coding/quality standards you mention above, but I see a difference
between fixing a warning and making a driver portable (to 64-bit
PowerPCs, to other platforms, etc.). If there is a kernel todo list
somewhere lets add to it the task to make the ucc_geth more portable.

> Then the driver can get enabled into the build on every
> platform, and therefore nobody will break the build of
> this driver again since it will get hit by "allmodconfig"
> et al. builds even on platforms other than the one it is
> meant for.
>=20
> This hack fix is not acceptable, really.

Are you suggesting we leave those warnings there until somebody decides
to fix all the portability issues of this driver? My patch is a small
and insignificant improvement and not the revolution you're asking for,
but is an small improvement today (I dislike warnings) vs. an improbable
big one in the future.

Leo, as author and maintainer of this driver, what's your take on this?


Cheers,
Emil.
