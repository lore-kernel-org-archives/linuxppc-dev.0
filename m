Return-Path: <qiang.zhao@nxp.com>
Received: from emea01-db3-obe.outbound.protection.outlook.com
 (mail-db3on0090.outbound.protection.outlook.com [157.55.234.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qR66p3JfQzDq6X
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 11:49:05 +1100 (AEDT)
From: Qiang Zhao <qiang.zhao@nxp.com>
To: Rob Herring <robh@kernel.org>
CC: "oss@buserror.net" <oss@buserror.net>, Yang-Leo Li <leoyang.li@nxp.com>,
 Xiaobo Xie <xiaobo.xie@nxp.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH v5 3/7] QE: Add uqe_serial document to bindings
Date: Fri, 18 Mar 2016 00:48:57 +0000
Message-ID: <AM3PR04MB118502C29D83E6251367E4E8918C0@AM3PR04MB1185.eurprd04.prod.outlook.com>
References: <1457486494-11377-1-git-send-email-qiang.zhao@nxp.com>
 <1457486494-11377-3-git-send-email-qiang.zhao@nxp.com>
 <20160317162749.GA7872@rob-hp-laptop>
In-Reply-To: <20160317162749.GA7872@rob-hp-laptop>
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


On Fri, Mar 18, 2016 at 12:28AM, Rob Herring wrote:
> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Friday, March 18, 2016 12:28 AM
> To: Qiang Zhao <qiang.zhao@nxp.com>
> Cc: oss@buserror.net; Yang-Leo Li <leoyang.li@nxp.com>; Xiaobo Xie
> <xiaobo.xie@nxp.com>; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH v5 3/7] QE: Add uqe_serial document to bindings
>=20
> On Wed, Mar 09, 2016 at 09:21:30AM +0800, Zhao Qiang wrote:
> > Add uqe_serial document to
> > Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt
> >
> > Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> > ---
> > Changes for v2
> > 	- modify tx/rx-clock-name specification Changes for v3
> > 	- NA
> > Changes for v4
> > 	- drop device_type
> > 	- modify to SoC specific compatible
> > Changes for v5
> > 	- add fsl to compatible as prefix
> >
> >  .../bindings/powerpc/fsl/cpm_qe/uqe_serial.txt         | 18
> ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt
>=20
> Acked-by: Rob Herring <robh@kernel.org>

Thank you for reviewing!

BR
-Zhao Qiang
