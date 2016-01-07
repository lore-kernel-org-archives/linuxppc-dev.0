Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0103.outbound.protection.outlook.com [207.46.100.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AD8FA1A0CA7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2016 07:40:49 +1100 (AEDT)
Message-ID: <1452199237.19133.26.camel@freescale.com>
Subject: Re: [PATCH] mtd: nand: add FSL_SOC dependency to drivers using FSL_LBC
From: Scott Wood <scottwood@freescale.com>
To: Brian Norris <computersforpeace@gmail.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-mtd@lists.infradead.org>
Date: Thu, 7 Jan 2016 14:40:37 -0600
In-Reply-To: <20160107203418.GJ109450@google.com>
References: <1452194501-115280-1-git-send-email-computersforpeace@gmail.com>
 <1452196053.19133.23.camel@freescale.com>
 <20160107203418.GJ109450@google.com>
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

On Thu, 2016-01-07 at 12:34 -0800, Brian Norris wrote:
> Hi Scott,
> 
> On Thu, Jan 07, 2016 at 01:47:33PM -0600, Scott Wood wrote:
> > On Thu, 2016-01-07 at 11:21 -0800, Brian Norris wrote:
> > > I've managed to construct .config files (for ppc64) that come across
> > > this Kconfig warning:
> > > 
> > >   warning: (MPC836x_RDK && MTD_NAND_FSL_ELBC && MTD_NAND_FSL_UPM)
> > > selects
> > > FSL_LBC which has unmet direct dependencies (FSL_SOC)
> > > 
> > > Let's add the FSL_SOC dependency to the NAND drivers. AFAICT, they are
> > > only supported on PPC32 FSL SoCs anyway.
> > 
> > There are other problems, if you can enable an 83xx board on ppc64. 
> >  PPC_83xx
> > does select FSL_SOC so I don't know why it's unmet.
> 
> I don't have an 83xx board enabled. I just have MTD_NAND_FSL_ELBC
> enabled; it only depends on PPC right now. Attaching the current test
> .config, for clarity.

Where did MPC836x_RDK come from above?

-Scott
