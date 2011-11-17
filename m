Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE009.bigfish.com (tx2ehsobe004.messaging.microsoft.com
 [65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 39FE5B7252
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2011 08:37:51 +1100 (EST)
Received: from mail73-tx2 (localhost.localdomain [127.0.0.1])	by
 mail73-tx2-R.bigfish.com (Postfix) with ESMTP id 9C4372F816F	for
 <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2011 21:37:42 +0000 (UTC)
Received: from TX2EHSMHS017.bigfish.com (unknown [10.9.14.241])	by
 mail73-tx2.bigfish.com (Postfix) with ESMTP id 80F0662004F	for
 <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2011 21:37:42 +0000 (UTC)
Date: Thu, 17 Nov 2011 15:37:33 -0600
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/85xx: p1022ds: enable monitor switching via
 pixis indirect mode
Message-ID: <20111117213733.GC14736@schlenkerla.am.freescale.net>
References: <1321556259-4459-1-git-send-email-timur@freescale.com>
 <1321556259-4459-2-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1321556259-4459-2-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 17, 2011 at 12:57:39PM -0600, Timur Tabi wrote:
> When the P1022's DIU video controller is active, the pixis must be accessed
> in "indirect" mode, which uses localbus chip select addresses.
> 
> Switching between the DVI and LVDS monitor ports is handled by the pixis,
> so that switching needs to be done via indirect mode.
> 
> This has the side-effect of no longer requiring U-Boot to enable the DIU.
> Now Linux can enable the DIU all by itself.

Under what circumstances does Linux do this?  How does Linux prevent the
NOR flash driver from binding to the device when this mode has been or
will be used?

-Scott
