Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0141.outbound.protection.outlook.com [65.55.169.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 836C61A0810
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 12:41:40 +1000 (AEST)
Message-ID: <1436323289.2658.61.camel@freescale.com>
Subject: Re: [RESEND] powerpc/diu: adjust DIU initialization entry
From: Scott Wood <scottwood@freescale.com>
To: Wang Dongsheng-B40534 <Dongsheng.Wang@freescale.com>
CC: Sun York-R58495 <yorksun@freescale.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Jin Zhengxiong-R64188
 <Jason.Jin@freescale.com>
Date: Tue, 7 Jul 2015 21:41:29 -0500
In-Reply-To: <SN1PR0301MB16161F3443AF7311DB42A36E9D910@SN1PR0301MB1616.namprd03.prod.outlook.com>
References: <1436255497-41207-1-git-send-email-dongsheng.wang@freescale.com>
 <1436305887.2658.49.camel@freescale.com>
 <SN1PR0301MB16161F3443AF7311DB42A36E9D910@SN1PR0301MB1616.namprd03.prod.outlook.com>
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

On Tue, 2015-07-07 at 21:30 -0500, Wang Dongsheng-B40534 wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Wednesday, July 08, 2015 5:51 AM
> > To: Wang Dongsheng-B40534
> > Cc: Sun York-R58495; linuxppc-dev@lists.ozlabs.org; Jin Zhengxiong-R64188
> > Subject: Re: [RESEND] powerpc/diu: adjust DIU initialization entry
> > 
> > On Tue, 2015-07-07 at 15:51 +0800, Dongsheng Wang wrote:
> > > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> > > 
> > > Move fsl_diu_init into diu probe function, because it should be
> > > initialized when system get diu device tree node, not always do
> > > initialization.
> > > 
> > > Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> > > ---
> > > Changes:
> > > Rebase original patch for upstream because fsl-diu-fb.c has moved to
> > > fbdev dir.
> > > 
> > > This patch is a long time ago, there is no feedback, and the Patchwork
> > > state has been modified for the changes requested, I don't know why.
> > > So I resend this patch to upstream.
> > 
> > Please send this to the proper list and maintainer, and with a subject 
> > prefix
> > that indicates it's an fbdev patch.
> > 
> Thanks.
> 
> I will send this patch to linux-fbdev@vger.kernel.org.
> 
> Please ignore this patch.

You still didn't fix the subject line...

-Scott
