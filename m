Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 06C842C0107
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Sep 2013 01:27:23 +1000 (EST)
Message-ID: <1378481146.12204.183.camel@snotra.buserror.net>
Subject: Re: [PATCH V3 2/2] powerpc/85xx: Add TWR-P1025 board support
From: Scott Wood <scottwood@freescale.com>
To: Xie Xiaobo-R63061 <r63061@freescale.com>
Date: Fri, 6 Sep 2013 10:25:46 -0500
In-Reply-To: <69EC9ED88E3CC04094A78F8074A7986D5D23CE@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1378116699-18826-1-git-send-email-X.Xie@freescale.com>
 <1378116699-18826-2-git-send-email-X.Xie@freescale.com>
 <1378311953.12204.20.camel@snotra.buserror.net>
 <69EC9ED88E3CC04094A78F8074A7986D5D23CE@039-SN1MPN1-003.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Johnston Michael-R49610 <r49610@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-09-06 at 05:01 -0500, Xie Xiaobo-R63061 wrote:
> Hi Scott,
> 
> Thanks for your reminding and advice.
> 
> I discuss this with Liu Shengzhou(the first person that remind me
> #interrupt-cells is 4), he advised removing the interrupts property
> from the phy node, because the mdio used the poll way preferentially.

I don't follow... if the PHYs have interrupts, why would we prefer to
poll?

In any case, the device tree describes the hardware, not how you'd
prefer to use it.

-Scott
