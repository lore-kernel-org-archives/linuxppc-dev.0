Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yRvps6CjNzDr4H
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Nov 2017 04:09:57 +1100 (AEDT)
Date: Wed, 1 Nov 2017 18:09:45 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Qiang Zhao <qiang.zhao@nxp.com>
cc: Michael Ellerman <mpe@ellerman.id.au>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, "oss@buserror.net" <oss@buserror.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Xiaobo Xie <xiaobo.xie@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v10 0/4] this patchset is to remove PPCisms for QEIC
In-Reply-To: <AM3PR04MB11851996C67BF447B8192821915F0@AM3PR04MB1185.eurprd04.prod.outlook.com>
Message-ID: <alpine.DEB.2.20.1711011808260.1942@nanos>
References: <1502075236-24078-1-git-send-email-qiang.zhao@nxp.com>
 <AM3PR04MB1185BD257F6BDE880B2C92B391470@AM3PR04MB1185.eurprd04.prod.outlook.com>
 <AM3PR04MB11852211CAFA9741B260D4A3915E0@AM3PR04MB1185.eurprd04.prod.outlook.com>
 <87bmkm95te.fsf@concordia.ellerman.id.au>
 <AM3PR04MB11851996C67BF447B8192821915F0@AM3PR04MB1185.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 1 Nov 2017, Qiang Zhao wrote:
> Michael Ellerman <mpe@ellerman.id.au> wrote
> > 
> > Qiang Zhao <qiang.zhao@nxp.com> writes:
> > 
> > > Hi all,
> > >
> > > Could anybody review this patchset and take action on them? Thank you!
> > 
> > Who maintains this? I don't actually know, it's not powerpc code, or is it?
> 
> Yes, it's not powerpc code, it is irqchip code, maintained by Thomas, Jason and Marc according to MAINTAINERS file.
> 
> Hi Thomas, Jason and Marc,
> 
> Could you keep an eye on this patchset? Thank you!

It's on my radar, but I have zero capacity at the moment. Hopefully Marc
can spare a few cycles.

Thanks,

	tglx
