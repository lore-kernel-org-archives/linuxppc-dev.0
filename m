Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 35660DDE3C
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 13:38:35 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l9N3cTP4004216
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 20:38:29 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l9N3cRSc028564
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 22:38:28 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] [POWERPC] ucc_geth: Eliminate compile warnings
Date: Tue, 23 Oct 2007 11:38:25 +0800
Message-ID: <989B956029373F45A0B8AF0297081890019B5E2E@zch01exm26.fsl.freescale.net>
In-Reply-To: <598D5675D34BE349929AF5EDE9B03E2701685446@az33exm24.fsl.freescale.net>
References: <1192745713-20829-1-git-send-email-Emilian.Medve@Freescale.com><20071018.173032.48505868.davem@davemloft.net><598D5675D34BE349929AF5EDE9B03E270168520B@az33exm24.fsl.freescale.net>
	<20071019.164143.75786621.davem@davemloft.net>
	<598D5675D34BE349929AF5EDE9B03E2701685446@az33exm24.fsl.freescale.net>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Medve Emilian-EMMEDVE1" <Emilian.Medve@freescale.com>,
	"David Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, jgarzik@pobox.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Medve Emilian-EMMEDVE1=20
> Sent: Monday, October 22, 2007 9:48 PM
> To: David Miller
> Cc: jgarzik@pobox.com; Li Yang-r58472;=20
> netdev@vger.kernel.org; linuxppc-dev@ozlabs.org
> Subject: RE: [PATCH] [POWERPC] ucc_geth: Eliminate compile warnings
>=20
> Hello David,
>=20
>=20
> > No piece of code in the kernel should live in a vacuum.
> >=20
> > In order to improve overall code quality, every piece of=20
> driver code=20
> > should avoid assuming things about pointer sizes and things of this=20
> > nature.
>=20
> I'm afraid we might be talking about orthogonal issues here.=20
> I actively agree that all code (not only kernel) should be=20
> written up to the coding/quality standards you mention above,=20
> but I see a difference between fixing a warning and making a=20
> driver portable (to 64-bit PowerPCs, to other platforms,=20
> etc.). If there is a kernel todo list somewhere lets add to=20
> it the task to make the ucc_geth more portable.
>=20
> > Then the driver can get enabled into the build on every=20
> platform, and=20
> > therefore nobody will break the build of this driver again since it=20
> > will get hit by "allmodconfig"
> > et al. builds even on platforms other than the one it is meant for.
> >=20
> > This hack fix is not acceptable, really.
>=20
> Are you suggesting we leave those warnings there until=20
> somebody decides to fix all the portability issues of this=20
> driver? My patch is a small and insignificant improvement and=20
> not the revolution you're asking for, but is an small=20
> improvement today (I dislike warnings) vs. an improbable big=20
> one in the future.

I'd say we can not use our way of doing things while working with the
community.  The community has to consider the kernel as a whole and thus
has its own virtue.  The warning has been there for some time.  It stays
as an indicator that we have something to do to improve the portability.
I will work on a patch to fix this portability issue.

- Leo
