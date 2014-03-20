Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0235.outbound.protection.outlook.com [207.46.163.235])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1AD9F2C009F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 11:51:27 +1100 (EST)
Message-ID: <1395276676.12479.304.camel@snotra.buserror.net>
Subject: Re: [PATCH] T1040RDB: add qe node for T1040RDB dts
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang-B45475 <qiang.zhao@freescale.com>
Date: Wed, 19 Mar 2014 19:51:16 -0500
In-Reply-To: <f07545053329444e9022bd43dc7d66c4@BLUPR03MB341.namprd03.prod.outlook.com>
References: <1394612762-36308-1-git-send-email-B45475@freescale.com>
 <1394649930.13761.154.camel@snotra.buserror.net>
 <f07545053329444e9022bd43dc7d66c4@BLUPR03MB341.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Xie
 Xiaobo-R63061 <X.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-03-12 at 20:56 -0500, Zhao Qiang-B45475 wrote:
> On Wed, 2014-03-13 at 2:46 AM, Scott wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Thursday, March 13, 2014 2:46 AM
> > To: Zhao Qiang-B45475
> > Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421; Xie Xiaobo-R63061
> > Subject: Re: [PATCH] T1040RDB: add qe node for T1040RDB dts
> > 
> > On Wed, 2014-03-12 at 16:26 +0800, Zhao Qiang wrote:
> > > Signed-off-by: Zhao Qiang <B45475@freescale.com>
> > > ---
> > >  arch/powerpc/boot/dts/t1040rdb.dts | 43
> > > ++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 43 insertions(+)
> > 
> > Presumably this is on top of this patch:
> > http://patchwork.ozlabs.org/patch/314138/
> > 
> > ...since there's no existing t1040 device tree support.  Always mention
> > when your patch is on top of a patch that hasn't yet been merged and
> > isn't in the same patch set.
> > 
> > At least some of this stuff seems like it should be in t1040si-post.dts
> > (or a file included by it), rather than the board dts.
> 
> Every board can use ucc differently, It is not correct to put this node into t1040si-post.dtsi.
> For example t1040qds can use ucc1 to tdm while maybe t1040rdb use ucc1 to uart.

That's why I said "some". :-)

Anything that is specific to the board should be in the board file, but
it's not clear that everything in this patch is board-specific.
si/siram?  Reg/ranges on the qe node?  Etc.

-Scott
