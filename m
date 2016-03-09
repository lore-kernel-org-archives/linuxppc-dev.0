Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 98A0C1A0007
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 11:13:19 +1100 (AEDT)
Message-ID: <1457482393.5360.115.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Qiang Zhao <qiang.zhao@nxp.com>, Rob Herring <robh@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Xiaobo Xie
 <xiaobo.xie@nxp.com>, Yang-Leo Li <leoyang.li@nxp.com>
Date: Tue, 08 Mar 2016 18:13:13 -0600
In-Reply-To: <AM3PR04MB1185D8F20D8D2763DB909B3791B20@AM3PR04MB1185.eurprd04.prod.outlook.com>
References: <1456816183-22340-1-git-send-email-qiang.zhao@nxp.com>
 <1456816183-22340-3-git-send-email-qiang.zhao@nxp.com>
 <20160305042536.GD13525@rob-hp-laptop>
 <AM3PR04MB11852B62A075A980A246D2D091B10@AM3PR04MB1185.eurprd04.prod.outlook.com>
 <1457371686.5360.107.camel@buserror.net>
 <AM3PR04MB1185D8F20D8D2763DB909B3791B20@AM3PR04MB1185.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH v3 3/7] QE: Add uqe_serial document to bindings
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-03-08 at 01:16 +0000, Qiang Zhao wrote:
> On Tue, Mar 08, 2016 at 1:28AM, Scott Wood wrote:
> > -----Original Message-----
> > From: Scott Wood [mailto:oss@buserror.net]
> > Sent: Tuesday, March 08, 2016 1:28 AM
> > To: Qiang Zhao <qiang.zhao@nxp.com>; Rob Herring <robh@kernel.org>
> > Cc: Yang-Leo Li <leoyang.li@nxp.com>; Xiaobo Xie <xiaobo.xie@nxp.com>;
> > linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; linuxppc-
> > dev@lists.ozlabs.org
> > Subject: Re: [PATCH v3 3/7] QE: Add uqe_serial document to bindings
> > 
> > On Mon, 2016-03-07 at 02:35 +0000, Qiang Zhao wrote:
> > > On Tue, Mar 05, 2016 at 12:26PM, Rob Herring wrote:
> > > > -----Original Message-----
> > > > From: Rob Herring [mailto:robh@kernel.org]
> > > > Sent: Saturday, March 05, 2016 12:26 PM
> > > > To: Qiang Zhao <qiang.zhao@nxp.com>
> > > > Cc: oss@buserror.net; Yang-Leo Li <leoyang.li@nxp.com>; Xiaobo Xie
> > > > <xiaobo.xie@nxp.com>; linux-kernel@vger.kernel.org;
> > > > devicetree@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> > > > Subject: Re: [PATCH v3 3/7] QE: Add uqe_serial document to bindings
> > > > 
> > > > On Tue, Mar 01, 2016 at 03:09:39PM +0800, Zhao Qiang wrote:
> > > > > Add uqe_serial document to
> > > > > Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.tx
> > > > > t
> > > > > 
> > > > > Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> > > > > ---
> > > > > Changes for v2
> > > > > 	- modify tx/rx-clock-name specification Changes for v2
> > > > > 	- NA
> > > > > 
> > > > >  .../bindings/powerpc/fsl/cpm_qe/uqe_serial.txt        | 19
> > > > +++++++++++++++++++
> > > > >  1 file changed, 19 insertions(+)
> > > > >  create mode 100644
> > > > > Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.tx
> > > > > t
> > > > > 
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.
> > > > > txt
> > > > > b/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.
> > > > > txt
> > > > > new file mode 100644
> > > > > index 0000000..436c71c
> > > > > --- /dev/null
> > > > > +++
> > b/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.
> > > > > +++ txt
> > > > > @@ -0,0 +1,19 @@
> > > > > +* Serial
> > > > > +
> > > > > +Currently defined compatibles:
> > > > > +- ucc_uart
> > > > 
> > > > I guess this is in use already and okay. However, looking at the
> > > > driver there really should be SoC specific compatible strings here
> > > > since the driver is looking up the SoC compatible string and
> > > > composing the firmware filename from that.
> > > 
> > > Ok, I will changed both driver and this compatible.
> > 
> > But don't break existing device trees while doing so.
> 
> Do I need to send driver patch in this patchset or a individual patch?

Doesn't matter.

-Scott
