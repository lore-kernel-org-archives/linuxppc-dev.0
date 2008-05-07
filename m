Return-Path: <Jason.Jin@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D58B8DDE1D
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 19:35:52 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m479ZkiW017953
	for <linuxppc-dev@ozlabs.org>; Wed, 7 May 2008 02:35:46 -0700 (MST)
Received: from zch01exm27.fsl.freescale.net (zch01exm27.ap.freescale.net
	[10.192.129.223])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m479Zi7w005810
	for <linuxppc-dev@ozlabs.org>; Wed, 7 May 2008 04:35:45 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 4/4] booting-without-of for Freescale MSI
Date: Wed, 7 May 2008 17:35:43 +0800
Message-ID: <CC27DED0F8F39E48A7E75FD768688B7A8C14C7@zch01exm27.fsl.freescale.net>
In-Reply-To: <d731595be98f00bf5387444b88de4883@kernel.crashing.org>
References: <1209973634-1699-1-git-send-email-Jason.jin@freescale.com>
	<1209973634-1699-2-git-send-email-Jason.jin@freescale.com>
	<1209973634-1699-3-git-send-email-Jason.jin@freescale.com>
	<1209973634-1699-4-git-send-email-Jason.jin@freescale.com>
	<79f7e810cc79d5912587296c4f44b419@kernel.crashing.org>
	<CC27DED0F8F39E48A7E75FD768688B7A8C1399@zch01exm27.fsl.freescale.net>
	<d731595be98f00bf5387444b88de4883@kernel.crashing.org>
From: "Jin Zhengxiong" <Jason.Jin@freescale.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > >
> > Thanks for your input. I think the name "fsl,MPIC-MSI" and=20
> > "fsl,IPIC-MSI"
> > is somethind specific.
>=20
> This is the third MSI-on-MPIC I've seen, and I doubt it will=20
> be the last.  It is likely FSL will make some different one=20
> in the future, as well.
>=20
This is the first patch for the FSL MSI support, I wish it can be
used for most of the freescale board if the PIC is still MPIC or IPIC.

> Please don't use generic names for specific devices.
>=20
How about using "fsl,85xx-MSI" for 85xx board, "fsl,86xx-MSI" for
86xx board and so on.

Jason
