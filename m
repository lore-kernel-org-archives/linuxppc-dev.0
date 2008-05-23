Return-Path: <Jason.Jin@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 93B26DE03A
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 18:34:33 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m4N8YPuo021253
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 01:34:26 -0700 (MST)
Received: from zch01exm27.fsl.freescale.net (zch01exm27.ap.freescale.net
	[10.192.129.223])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m4N8YNS7025932
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 03:34:24 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH v2] [POWERPC] mpic: deal with bogus NIRQ in
	FeatureReporting Register
Date: Fri, 23 May 2008 16:34:23 +0800
Message-ID: <CC27DED0F8F39E48A7E75FD768688B7A915B4E@zch01exm27.fsl.freescale.net>
In-Reply-To: <0855C418-66AB-4335-A677-371E5DC08B5C@kernel.crashing.org>
References: <Pine.LNX.4.64.0805211559110.31758@blarg.am.freescale.net>
	<1211403708.8297.251.camel@pasglop>
	<CC27DED0F8F39E48A7E75FD768688B7A915AB8@zch01exm27.fsl.freescale.net>
	<0855C418-66AB-4335-A677-371E5DC08B5C@kernel.crashing.org>
From: "Jin Zhengxiong" <Jason.Jin@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20
> On May 22, 2008, at 9:15 PM, Jin Zhengxiong wrote:
>=20
> > Hi, Kumar,
> >
> > So I should  change the MSI hwirq num according to this change, The=20
> > patches will be send after this changes updated to your tree. How=20
> > about applying the MSI driver firstly?
>=20
> I've asked Paul to pick up this patch for powerpc-next.  If=20
> you can rework the MSI patches with this patch applied and=20
> just change the board support for mpc85xx_ds and 8610 to set the flag.
>=20

Ok, Please find the patchset in the following mail. I'll resend the MSI
driver in this send.

Jason
