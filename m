Return-Path: <qiang.zhao@nxp.com>
Received: from emea01-am1-obe.outbound.protection.outlook.com
 (mail-am1on0100.outbound.protection.outlook.com [157.56.112.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AC1B31A0008
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 15:44:52 +1100 (AEDT)
From: Qiang Zhao <qiang.zhao@nxp.com>
To: Rob Herring <robh@kernel.org>
CC: "oss@buserror.net" <oss@buserror.net>, Yang-Leo Li <leoyang.li@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH v2 3/7] QE: Add uqe_serial document to bindings
Date: Thu, 25 Feb 2016 04:44:44 +0000
Message-ID: <AM3PR04MB1185D43F4D2C5F9228DB99F591A60@AM3PR04MB1185.eurprd04.prod.outlook.com>
References: <1455757572-44955-1-git-send-email-qiang.zhao@nxp.com>
 <1455757572-44955-3-git-send-email-qiang.zhao@nxp.com>
 <20160223202342.GA9008@rob-hp-laptop>
In-Reply-To: <20160223202342.GA9008@rob-hp-laptop>
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


On Wed, Feb 24, 2016 at 04:24AM, Rob Herring wrote:
> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Wednesday, February 24, 2016 4:24 AM
> To: Qiang Zhao <qiang.zhao@nxp.com>
> Cc: oss@buserror.net; Yang-Leo Li <leoyang.li@nxp.com>; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org
> Subject: Re: [PATCH v2 3/7] QE: Add uqe_serial document to bindings
>=20
> On Thu, Feb 18, 2016 at 09:06:08AM +0800, Zhao Qiang wrote:
> > Add uqe_serial document to
> > Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt
> >
> > Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> > ---
> > Changes for v2
> > 	- modify tx/rx-clock-name specification
> >
> >  .../bindings/powerpc/fsl/cpm_qe/uqe_serial.txt        | 19
> +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt
> >
> > diff --git
> > a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt
> > b/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt
> > new file mode 100644
> > index 0000000..436c71c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.
> > +++ txt
> > @@ -0,0 +1,19 @@
> > +* Serial
> > +
> > +Currently defined compatibles:
> > +- ucc_uart
> > +
> > +Properties for ucc_uart:
> > +port-number : port number of UCC-UART
>=20
> How is this used?

It used for uart port index.

BR
-Zhao
