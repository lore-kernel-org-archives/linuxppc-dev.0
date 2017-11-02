Return-Path: <qiang.zhao@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0063.outbound.protection.outlook.com [104.47.2.63])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yS79n015vzDr6m
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Nov 2017 12:42:04 +1100 (AEDT)
From: Qiang Zhao <qiang.zhao@nxp.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: Michael Ellerman <mpe@ellerman.id.au>, Jason Cooper
 <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>,
 "oss@buserror.net" <oss@buserror.net>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Xiaobo Xie <xiaobo.xie@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v10 0/4] this patchset is to remove PPCisms for QEIC
Date: Thu, 2 Nov 2017 01:41:58 +0000
Message-ID: <AM3PR04MB1185C2803B8DC99F6AE57580915C0@AM3PR04MB1185.eurprd04.prod.outlook.com>
References: <1502075236-24078-1-git-send-email-qiang.zhao@nxp.com>
 <AM3PR04MB1185BD257F6BDE880B2C92B391470@AM3PR04MB1185.eurprd04.prod.outlook.com>
 <AM3PR04MB11852211CAFA9741B260D4A3915E0@AM3PR04MB1185.eurprd04.prod.outlook.com>
 <87bmkm95te.fsf@concordia.ellerman.id.au>
 <AM3PR04MB11851996C67BF447B8192821915F0@AM3PR04MB1185.eurprd04.prod.outlook.com>
 <alpine.DEB.2.20.1711011808260.1942@nanos>
In-Reply-To: <alpine.DEB.2.20.1711011808260.1942@nanos>
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

On Wed, 1 Nov 2017, Thomas Gleixner <tglx@linutronix.de> wrote:


> -----Original Message-----
> From: Thomas Gleixner [mailto:tglx@linutronix.de]
> Sent: Thursday, November 02, 2017 1:10 AM
> To: Qiang Zhao <qiang.zhao@nxp.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>; Jason Cooper
> <jason@lakedaemon.net>; Marc Zyngier <marc.zyngier@arm.com>;
> oss@buserror.net; linuxppc-dev@lists.ozlabs.org; Xiaobo Xie
> <xiaobo.xie@nxp.com>; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH v10 0/4] this patchset is to remove PPCisms for QEIC
>=20
> On Wed, 1 Nov 2017, Qiang Zhao wrote:
> > Michael Ellerman <mpe@ellerman.id.au> wrote
> > >
> > > Qiang Zhao <qiang.zhao@nxp.com> writes:
> > >
> > > > Hi all,
> > > >
> > > > Could anybody review this patchset and take action on them? Thank y=
ou!
> > >
> > > Who maintains this? I don't actually know, it's not powerpc code, or =
is it?
> >
> > Yes, it's not powerpc code, it is irqchip code, maintained by Thomas, J=
ason and
> Marc according to MAINTAINERS file.
> >
> > Hi Thomas, Jason and Marc,
> >
> > Could you keep an eye on this patchset? Thank you!
>=20
> It's on my radar, but I have zero capacity at the moment. Hopefully Marc =
can
> spare a few cycles.
>=20
> Thanks,
>=20
> 	tglx

Thank you!

Best Regards
Qiang Zhao
