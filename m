Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0103.outbound.protection.outlook.com [157.56.111.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF1B71A074A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 07:01:38 +1000 (AEST)
Message-ID: <1428958878.22867.639.camel@freescale.com>
Subject: Re: [PATCH 1/4 v2] powerpc/fsl-booke: Add device tree support for
 T1024/T1023 SoC
From: Scott Wood <scottwood@freescale.com>
To: Liu Shengzhou-B36685 <Shengzhou.Liu@freescale.com>
Date: Mon, 13 Apr 2015 16:01:18 -0500
In-Reply-To: <DM2PR03MB398F574033070CAB40E9945F8FB0@DM2PR03MB398.namprd03.prod.outlook.com>
References: <1428489987-31209-1-git-send-email-Shengzhou.Liu@freescale.com>
 <1428533550.22867.522.camel@freescale.com>
 <DM2PR03MB398F574033070CAB40E9945F8FB0@DM2PR03MB398.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-04-09 at 01:29 -0500, Liu Shengzhou-B36685 wrote:
> > > +&soc {
> > > +/include/ "qoriq-tdm1.0.dtsi"
> > 
> > Where is this file?  Is there some dependency you've forgotten to mention?
> > 
> > If this is meant to apply after
> > http://patchwork.ozlabs.org/patch/457605/
> > is that really QUICC engine TDM as described in the comment above?
> > 
> > -Scott
> Yes, it depends on http://patchwork.ozlabs.org/patch/457605/
> right that's really QUICC engine TDM.

That doesn't look like anything related to the QUICC engine, and CCSR
offset 0x185000 is reserved in the t1024 manual.

-Scott
