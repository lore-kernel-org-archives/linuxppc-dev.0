Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0125.outbound.protection.outlook.com [65.55.169.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A98A71A0F6F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 04:37:43 +1000 (AEST)
Message-ID: <1433961449.2477.107.camel@freescale.com>
Subject: Re: [PATCH V2] QorIQ/TMU: add TMU node to device tree for QorIQ T104x
From: Scott Wood <scottwood@freescale.com>
To: Jia Hongtao-B38951 <hongtao.jia@freescale.com>
CC: "edubezval@gmail.com" <edubezval@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, "rui.zhang@intel.com"
 <rui.zhang@intel.com>
Date: Wed, 10 Jun 2015 13:37:29 -0500
In-Reply-To: <BLUPR03MB1499AA1359894C6B1F801FCE1BD0@BLUPR03MB149.namprd03.prod.outlook.com>
References: <1429085868-47577-1-git-send-email-hongtao.jia@freescale.com>
 <BLUPR03MB1498C018F80A754767DF48FE1CC0@BLUPR03MB149.namprd03.prod.outlook.com>
 <1432669078.7862.13.camel@freescale.com>
 <BLUPR03MB149DC0A753423EB27293931E1BE0@BLUPR03MB149.namprd03.prod.outlook.com>
 <1433872049.2477.80.camel@freescale.com>
 <BLUPR03MB1499AA1359894C6B1F801FCE1BD0@BLUPR03MB149.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-06-10 at 03:56 -0500, Jia Hongtao-B38951 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Wednesday, June 10, 2015 1:47 AM
> > To: Jia Hongtao-B38951
> > Cc: edubezval@gmail.com; linuxppc-dev@lists.ozlabs.org;
> > devicetree@vger.kernel.org; robh+dt@kernel.org; rui.zhang@intel.com
> > Subject: Re: [PATCH V2] QorIQ/TMU: add TMU node to device tree for 
> > QorIQ
> > T104x
> > 
> > On Mon, 2015-06-08 at 21:19 -0500, Jia Hongtao-B38951 wrote:
> > > > -----Original Message-----
> > > > From: Wood Scott-B07421
> > > > Sent: Wednesday, May 27, 2015 3:38 AM
> > > > To: Jia Hongtao-B38951
> > > > Cc: edubezval@gmail.com; linuxppc-dev@lists.ozlabs.org;
> > > > devicetree@vger.kernel.org; robh+dt@kernel.org; 
> > > > rui.zhang@intel.com
> > > > Subject: Re: [PATCH V2] QorIQ/TMU: add TMU node to device tree 
> > > > for
> > > > QorIQ T104x
> > > > 
> > > > On Tue, 2015-05-26 at 01:33 -0500, Jia Hongtao-B38951 wrote:
> > > > > diff --git a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
> > > > > > b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
> > > > > > index 15ae462..bb9f792 100644
> > > > > > --- a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
> > > > > > +++ b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
> > > > > > @@ -345,6 +345,7 @@
> > > > > >             reg        = <0xea000 0x4000>;
> > > > > >     };
> > > > > > 
> > > > > > +/include/ "qoriq-tmu-t104xsi.dtsi"
> > > > > >  /include/ "elo3-dma-0.dtsi"
> > > > > >  /include/ "elo3-dma-1.dtsi"
> > > > > >  /include/ "qoriq-espi-0.dtsi"
> > > > 
> > > > Why is this chip-specific enough to be called "t104xsi", but 
> > > > not
> > > > chip-
> > > > specific enough to just go directly into t1040si-post?
> 
> The tmu node includes lots of contents.
> Is it looks messy if just go directly into t1040si-post?

I don't think it's too much to go into the main file.  Having too many 
files is a hassle as well...

-Scott
