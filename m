Return-Path: <Shengzhou.Liu@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0184.outbound.protection.outlook.com [207.46.163.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 642F92C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 21:06:55 +1100 (EST)
From: "Shengzhou.Liu@freescale.com" <Shengzhou.Liu@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH] net/phy: Add Cortina CS43xx PHY support
Date: Wed, 5 Mar 2014 09:52:28 +0000
Message-ID: <6e5f5052190a46e1ba0a11254a657326@DM2PR03MB398.namprd03.prod.outlook.com>
References: <1394007391-32256-1-git-send-email-Shengzhou.Liu@freescale.com>
 <CFF70C14-23B1-45B9-AD84-C33E32F0B9A3@kernel.crashing.org>
In-Reply-To: <CFF70C14-23B1-45B9-AD84-C33E32F0B9A3@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "B43619@freescale.com" <B43619@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sure, will too post to netdev list.

Regards,
Shengzhou


> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Wednesday, March 05, 2014 5:30 PM
> To: Liu Shengzhou-B36685
> Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421; Cao Yong Hua-B43619
> Subject: Re: [PATCH] net/phy: Add Cortina CS43xx PHY support
>=20
>=20
> On Mar 5, 2014, at 2:16 AM, Shengzhou Liu <Shengzhou.Liu@freescale.com>
> wrote:
>=20
> > Add support for Cortina CS4315/CS4340 10G PHY.
> > (Tested with CS4315 on T2080RDB and CS4340 on T4240RDB).
> >
> > Signed-off-by: YongHua Cao <B43619@freescale.com>
> > Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> > ---
> > drivers/net/phy/Kconfig   |  5 +++
> > drivers/net/phy/Makefile  |  1 +
> > drivers/net/phy/cortina.c | 92
> +++++++++++++++++++++++++++++++++++++++++++++++
> > 3 files changed, 98 insertions(+)
> > create mode 100644 drivers/net/phy/cortina.c
>=20
> This patch really needs to be posted to the netdev list
>=20
> - k
