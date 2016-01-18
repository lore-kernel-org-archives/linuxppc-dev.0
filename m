Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 734F61A0023
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2016 10:08:02 +1100 (AEDT)
Message-ID: <1453158476.19133.70.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoli@freescale.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, lkml
 <linux-kernel@vger.kernel.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>,  "Priyanka.Jain@freescale.com"
 <Priyanka.Jain@freescale.com>
Date: Mon, 18 Jan 2016 17:07:56 -0600
In-Reply-To: <AM3PR04MB11851EDA91BA3C1D7386BC8D91C00@AM3PR04MB1185.eurprd04.prod.outlook.com>
References: <1452219494-31947-1-git-send-email-qiang.zhao@nxp.com>
 <1452219494-31947-3-git-send-email-qiang.zhao@nxp.com>
 <CADRPPNS3qT+=zz60UKRSYwxpaphcE7e04SntOQ==RjoOfhQ68Q@mail.gmail.com>
 <AM3PR04MB11851EDA91BA3C1D7386BC8D91C00@AM3PR04MB1185.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH 3/6] QE: Add uqe_serial document to bindings
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-01-18 at 09:24 +0000, Qiang Zhao wrote:
> On Fri, Jan 18, 2016 at 05:10 PM, Li Yang <leoli@freescale.com>wrote:
> > -----Original Message-----
> > From: pku.leo@gmail.com [mailto:pku.leo@gmail.com] On Behalf Of Li Yang
> > Sent: Monday, January 18, 2016 5:10 PM
> > To: Qiang Zhao <qiang.zhao@nxp.com>
> > Cc: devicetree@vger.kernel.org; lkml <linux-kernel@vger.kernel.org>;
> > linuxppc-dev <linuxppc-dev@lists.ozlabs.org>; Priyanka.Jain@freescale.com;
> > oss@buserror.net
> > Subject: Re: [PATCH 3/6] QE: Add uqe_serial document to bindings
> > 
> > On Fri, Jan 8, 2016 at 10:18 AM, Zhao Qiang <qiang.zhao@nxp.com> wrote:
> > > Add uqe_serial document to
> > > Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt
> > 
> > As you have submitted patch to move QE code from arch/powerpc into
> > drivers/soc/fsl for the reuse of ARM and powerpc,  you should also move
> > the
> > binding documents out of the powerpc folder into a more common place and
> > add new bindings in the new location.
> 
> Thank you for your recommendation. 
> How about create a new directory named qe under
> "Documentation/devicetree/bindings/"? 
> Or you have a better suggestion?

Documentation/devicetree/bindings/soc/fsl/cpm_qe

-Scott
