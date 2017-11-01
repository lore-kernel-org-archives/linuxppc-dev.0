Return-Path: <qiang.zhao@nxp.com>
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10078.outbound.protection.outlook.com [40.107.1.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yRW971N5kzDqlM
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Nov 2017 12:39:22 +1100 (AEDT)
From: Qiang Zhao <qiang.zhao@nxp.com>
To: Michael Ellerman <mpe@ellerman.id.au>, "tglx@linutronix.de"
 <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier
 <marc.zyngier@arm.com>
CC: "oss@buserror.net" <oss@buserror.net>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Xiaobo Xie <xiaobo.xie@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v10 0/4] this patchset is to remove PPCisms for QEIC
Date: Wed, 1 Nov 2017 01:39:15 +0000
Message-ID: <AM3PR04MB11851996C67BF447B8192821915F0@AM3PR04MB1185.eurprd04.prod.outlook.com>
References: <1502075236-24078-1-git-send-email-qiang.zhao@nxp.com>
 <AM3PR04MB1185BD257F6BDE880B2C92B391470@AM3PR04MB1185.eurprd04.prod.outlook.com>
 <AM3PR04MB11852211CAFA9741B260D4A3915E0@AM3PR04MB1185.eurprd04.prod.outlook.com>
 <87bmkm95te.fsf@concordia.ellerman.id.au>
In-Reply-To: <87bmkm95te.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> wrote
>=20
> Qiang Zhao <qiang.zhao@nxp.com> writes:
>=20
> > Hi all,
> >
> > Could anybody review this patchset and take action on them? Thank you!
>=20
> Who maintains this? I don't actually know, it's not powerpc code, or is i=
t?

Yes, it's not powerpc code, it is irqchip code, maintained by Thomas, Jason=
 and Marc according to MAINTAINERS file.

Hi Thomas, Jason and Marc,

Could you keep an eye on this patchset? Thank you!

Best Regards
Qiang Zhao
