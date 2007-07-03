Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 90CA5DDEE3
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jul 2007 13:40:55 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l633ej0s024279
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Jul 2007 20:40:45 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l633eiCG006136
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Jul 2007 22:40:44 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] ucc_geth.c, make PHY device optional.
Date: Tue, 3 Jul 2007 11:42:39 +0800
Message-ID: <989B956029373F45A0B8AF0297081890D837CB@zch01exm26.fsl.freescale.net>
In-Reply-To: <012701c7bd0c$64fe67c0$0e67a8c0@Jocke>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>,
	"linuxppc-dev Development" <linuxppc-dev@ozlabs.org>,
	"Netdev" <netdev@vger.kernel.org>,
	"Fleming Andy-afleming" <afleming@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: netdev-owner@vger.kernel.org
[mailto:netdev-owner@vger.kernel.org] On
> Behalf Of Joakim Tjernlund
> Sent: Tuesday, July 03, 2007 8:52 AM
> To: 'linuxppc-dev Development'; 'Netdev'; Li Yang-r58472
> Subject: [PATCH] ucc_geth.c, make PHY device optional.
>=20
> > This patch makes the PHY optional for ucc_geth.c ethernet driver.
> > This is useful to support a direct mii to mii connection to, for
example,
> > a onboard swicth.
> >
> > Signed-off-by: Joakim Tjernlund <joakim.tjernlund@transmode.se>
> ----
Hi Joakim,

I'm wondering if we really need to have the option to disable phylib.
Actually we have made phylib selected by default for ucc_geth.  Many L2
switch chips have the capacity to be controlled.  Therefore they can be
managed as a phy device.  For the MII interface which is not
configurable, shouldn't we use the fixed phy support from Vitaly?

- Leo
