Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0106.outbound.protection.outlook.com [157.56.111.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 18E321A0E24
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jul 2015 03:33:30 +1000 (AEST)
Message-ID: <1436549595.2658.159.camel@freescale.com>
Subject: Re: [PATCH 02/11] soc/fsl: Introduce DPAA BMan device management
 driver
From: Scott Wood <scottwood@freescale.com>
To: Paul Bolle <pebolle@tiscali.nl>
CC: Roy Pledge <Roy.Pledge@freescale.com>, <linuxppc-dev@lists.ozlabs.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date: Fri, 10 Jul 2015 12:33:15 -0500
In-Reply-To: <1436528160.20619.159.camel@tiscali.nl>
References: <1436473322-21247-1-git-send-email-Roy.Pledge@freescale.com>
 <1436473322-21247-3-git-send-email-Roy.Pledge@freescale.com>
 <1436528160.20619.159.camel@tiscali.nl>
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

On Fri, 2015-07-10 at 13:36 +0200, Paul Bolle wrote:
> On do, 2015-07-09 at 16:21 -0400, Roy Pledge wrote:
> > +#ifdef CONFIG_FSL_DPA_CHECKING
> > +#define DPA_ASSERT(x) \
> > +   do { \
> > +           if (!(x)) { \
> > +                   pr_crit("ASSERT: (%s:%d) %s\n", __FILE__, __LINE__, \
> > +                           __stringify_1(x)); \
> > +                   dump_stack(); \
> > +                   panic("assertion failure"); \
> 
> Not my call, but why panic() here?

I'm pretty sure I've complained about this before (as well as all the 
BUG_ONs).

-Scott
