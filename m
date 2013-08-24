Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9957D2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Aug 2013 10:12:16 +1000 (EST)
Received: from mail170-va3 (localhost [127.0.0.1])	by
 mail170-va3-R.bigfish.com (Postfix) with ESMTP id 302B11E00FA	for
 <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Aug 2013 00:12:12 +0000 (UTC)
Received: from VA3EHSMHS001.bigfish.com (unknown [10.7.14.237])	by
 mail170-va3.bigfish.com (Postfix) with ESMTP id D765C420041	for
 <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Aug 2013 00:12:10 +0000 (UTC)
Message-ID: <1377303125.20722.112.camel@snotra.buserror.net>
Subject: Re: [v2] powerpc/85xx: Add P1023RDB board support
From: Scott Wood <scottwood@freescale.com>
To: Chunhe Lan <Chunhe.Lan@freescale.com>
Date: Fri, 23 Aug 2013 19:12:05 -0500
In-Reply-To: <20130824000930.GA29088@home.buserror.net>
References: <1375184429-22145-1-git-send-email-Chunhe.Lan@freescale.com>
 <20130824000930.GA29088@home.buserror.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-08-23 at 19:09 -0500, Scott Wood wrote:
> On Tue, Jul 30, 2013 at 07:40:29PM +0800, Chunhe Lan wrote:
> > P1023RDB Specification:
> > -----------------------
> > Memory subsystem:
> >    512MB DDR3 (Fixed DDR on board)
> >    64MB NOR flash
> >    128MB NAND flash
> > 
> > Ethernet:
> >    eTSEC1: Connected to Atheros AR8035 GETH PHY
> >    eTSEC2: Connected to Atheros AR8035 GETH PHY
> > 
> > PCIe:
> >    Three mini-PCIe slots
> > 
> > USB:
> >    Two USB2.0 Type A ports
> > 
> > I2C:
> >    AT24C08 8K Board EEPROM (8 bit address)
> > 
> > Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> > Cc: Scott Wood <scottwood@freescale.com>
> > 
> > ---
> 
> No changelog since v1...


Sigh, and now I see there was a v3 right after this that addressed most
of these issues. :-P

-Scott
