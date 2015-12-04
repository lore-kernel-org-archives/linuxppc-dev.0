Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0125.hostedemail.com
 [216.40.44.125])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D23671A0B73
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Dec 2015 07:00:42 +1100 (AEDT)
Message-ID: <1449259235.8611.19.camel@perches.com>
Subject: Re: [net-next v5 2/8] dpaa_eth: add support for DPAA Ethernet
From: Joe Perches <joe@perches.com>
To: David Miller <davem@davemloft.net>, madalin.bucur@freescale.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, scottwood@freescale.com,
 igal.liberman@freescale.com, ppc@mindchasers.com, pebolle@tiscali.nl,
 joakim.tjernlund@transmode.se, gregkh@linuxfoundation.org
Date: Fri, 04 Dec 2015 12:00:35 -0800
In-Reply-To: <20151204.145549.859527220803940077.davem@davemloft.net>
References: <1449150589-26253-1-git-send-email-madalin.bucur@freescale.com>
 <1449150589-26253-3-git-send-email-madalin.bucur@freescale.com>
 <20151204.145549.859527220803940077.davem@davemloft.net>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-12-04 at 14:55 -0500, David Miller wrote:
> From: Madalin Bucur <madalin.bucur@freescale.com>
> Date: Thu, 3 Dec 2015 15:49:43 +0200
> 
> > @@ -0,0 +1,22 @@
> > +menuconfig FSL_DPAA_ETH
> > +     tristate "DPAA Ethernet"
> > +     depends on FSL_SOC && FSL_BMAN && FSL_QMAN && FSL_FMAN
> > +     select PHYLIB
> > +     select FSL_FMAN_MAC
> 
> I do not see the FSL_FMAN_MAC Kconfig symbol defined anywhere in the
> tree.

I believe this patch series is dependent on two
other patch series mentioned in the cover letter.
---
The latest FMan driver patches were submitted by Igal Liberman:
https://patchwork.ozlabs.org/project/netdev/list/?submitter=64715&state=*

The latest Q/BMan drivers were submitted by Roy Pledge:
https://patchwork.ozlabs.org/project/linuxppc-dev/list/?submitter=66331&state=*
