Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0133.outbound.protection.outlook.com [65.55.169.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7D9441A003D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Dec 2014 09:01:35 +1100 (AEDT)
Message-ID: <1418940078.5581.143.camel@freescale.com>
Subject: Re: [PATCH] [v2] power/fsl: add MDIO dt binding for FMan
From: Scott Wood <scottwood@freescale.com>
To: Xie Shaohui-B21989 <Shaohui.Xie@freescale.com>
Date: Thu, 18 Dec 2014 16:01:18 -0600
In-Reply-To: <DM2PR0301MB08641FB289DBA17AD59FBEA0E26A0@DM2PR0301MB0864.namprd03.prod.outlook.com>
References: <1415958800-9867-1-git-send-email-shh.xie@gmail.com>
 <1416966592.15957.172.camel@freescale.com>
 <DM2PR0301MB08641FB289DBA17AD59FBEA0E26A0@DM2PR0301MB0864.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Medve
 Emilian-EMMEDVE1 <Emilian.Medve@freescale.com>,
 Liberman Igal-B31950 <Igal.Liberman@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-12-18 at 06:53 -0600, Xie Shaohui-B21989 wrote:
> Ping.
> 
> Best Regards, 
> Shaohui Xie

I can't put patches in my -next until the merge window closes.

> > > > +EXAMPLE
> > > > +
> > > > +Example for FMan v2 external MDIO:
> > > > +
> > > > +mdio@f1000 {
> > > > +	compatible = "fsl,fman-xmdio";
> > > > +	reg = <0xf1000 0x1000>;
> > > > +	bus-frequency = <20000>;
> > > > +};
> > >
> > > So the bus frequency is only 20 KHz?  Or is the unit supposed to be
> > > something other than Hz?
> > [S.H] it's only an example, it could be different on real SoCs, but they always
> > lower than the standard one, The standard one is 2.5MHz, I have to use Hz for it.

Is there any SoC for which 20 kHz is the right frequency?  I just want
to make sure the example is realistic.

-Scott
