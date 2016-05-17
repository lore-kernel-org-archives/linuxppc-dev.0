Return-Path: <qiang.zhao@nxp.com>
Received: from emea01-am1-obe.outbound.protection.outlook.com
 (mail-am1on0074.outbound.protection.outlook.com [157.56.112.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r7zxc5QqWzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 11:19:00 +1000 (AEST)
From: Qiang Zhao <qiang.zhao@nxp.com>
To: Scott Wood <oss@buserror.net>
CC: "robh+dt@kernel.org" <robh+dt@kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Xiaobo Xie <xiaobo.xie@nxp.com>, Yang-Leo Li
 <leoyang.li@nxp.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [v5,1/7] QE: Add IC, SI and SIRAM document to device tree
 bindings.
Date: Tue, 17 May 2016 01:18:52 +0000
Message-ID: <AM3PR04MB118504BB6430CBEC8AA4886491480@AM3PR04MB1185.eurprd04.prod.outlook.com>
References: <1457486494-11377-1-git-send-email-qiang.zhao@nxp.com>
 <20160516232210.GA21087@home.buserror.net>
In-Reply-To: <20160516232210.GA21087@home.buserror.net>
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

On Tue, May 17, 2016 at 07:22AM, Scott Wood wrote:
> -----Original Message-----
> From: Scott Wood [mailto:oss@buserror.net]
> Sent: Tuesday, May 17, 2016 7:22 AM
> To: Qiang Zhao <qiang.zhao@nxp.com>
> Cc: robh+dt@kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Xiaobo Xie <xiaobo.xie@nxp.com>; Yang-Leo Li
> <leoyang.li@nxp.com>; linuxppc-dev@lists.ozlabs.org
> Subject: Re: [v5,1/7] QE: Add IC, SI and SIRAM document to device tree
> bindings.
>=20
> On Wed, Mar 09, 2016 at 09:21:28AM +0800, Zhao Qiang wrote:
> > Add IC, SI and SIRAM document of QE to
> > Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/qe.txt
> >
> > Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> > changes for v2
> > 	- Add interrupt-controller in Required properties
> > 	- delete address-cells and size-cells for qe-si and qe-siram Changes
> > for v3
> > 	- Add SoC specific caompatible strings to qe-si and qe-siram Changes
> > for v4
> > 	- NA
> > Changes for v5
> > 	- NA
> >
> >  .../devicetree/bindings/powerpc/fsl/cpm_qe/qe.txt  | 50
> > ++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> > +* Serial Interface Block (SI)
> > +
> > +The SI manages the routing of eight TDM lines to the QE block serial
> > +drivers , the MCC and the UCCs, for receive and transmit.
> > +
> > +Required properties:
> > +- compatible : should be "fsl,t1040-qe-si".
> > +- reg : Address range of SI register set.
>=20
> Is t1040 the only chip that has or will ever have this?

There also be t1024 and ls1043 supporting si.
I thought to add them when adding their device node.
If you think it is better to add them now, I will modify.

-Zhao Qiang
