Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0109.outbound.protection.outlook.com [207.46.100.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 16FC21A0BE0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 05:37:20 +1000 (AEST)
Message-ID: <1429558605.4352.21.camel@freescale.com>
Subject: Re: [PATCH] powerpc/dts: Move pll0/1-div4 index
From: Scott Wood <scottwood@freescale.com>
To: Liberman Igal-B31950 <Igal.Liberman@freescale.com>
Date: Mon, 20 Apr 2015 14:36:45 -0500
In-Reply-To: <DM2PR03MB38320A3D701B771E163B8F3E6E00@DM2PR03MB383.namprd03.prod.outlook.com>
References: <1429186105-6991-1-git-send-email-igal.liberman@freescale.com>
 <1429249343.32545.53.camel@freescale.com>
 <DM2PR03MB38320A3D701B771E163B8F3E6E00@DM2PR03MB383.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-04-20 at 06:10 -0500, Liberman Igal-B31950 wrote:
> 
> 
> Regards,
> Igal Liberman.
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Friday, April 17, 2015 8:42 AM
> > To: Liberman Igal-B31950
> > Cc: devicetree@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH] powerpc/dts: Move pll0/1-div4 index
> > 
> > On Thu, 2015-04-16 at 15:08 +0300, Igal.Liberman wrote:
> > > From: Igal Liberman <Igal.Liberman@freescale.com>
> > >
> > > This patch updates pll0/1-div4 index to '3'.
> > > Originally it was '2'.
> > >
> > > The following patch adds pll0/1-div3 option:
> > > 	https://patchwork.ozlabs.org/patch/461151/
> > > After this patch, index '2' becomes pll0/1-div3.
> > >
> > > This patch based on top of the following:
> > > 	https://patchwork.ozlabs.org/patch/461811/
> > >
> > > Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
> > 
> > This needs to be done in the same patch as the provider change, to avoid a
> > buggy intermediate state.
> > 
> > Will there be a new binding patch coming?
> > 
> 
> OK, I'll add those changes as on patch.
> 
> Regarding the binding,
> I already submitted https://patchwork.ozlabs.org/patch/461150/

Which is an incompatible change as I noted in a comment on a different
patch.

> Do you mean that I should add comment that the driver parses the node by reading the number of input clocks and not the compatible?

No, you should make the binding document reflect how things currently
work.

-Scott
