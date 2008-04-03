Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id EA6EBDDE09
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 16:06:17 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] [POWERPC] 4xx: Create common ppc4xx_reset_system() in
	ppc4xx_soc.c
Date: Thu, 3 Apr 2008 07:02:55 +0200
References: <1206629011-28821-1-git-send-email-sr@denx.de>
	<20080402202546.24ac1a95@zod.rchland.ibm.com>
In-Reply-To: <20080402202546.24ac1a95@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804030702.57945.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 03 April 2008, Josh Boyer wrote:
> On Thu, 27 Mar 2008 15:43:31 +0100
>
> Stefan Roese <sr@denx.de> wrote:
> > diff --git a/arch/powerpc/platforms/44x/sequoia.c
> > b/arch/powerpc/platforms/44x/sequoia.c index d279db4..1782d41 100644
> > --- a/arch/powerpc/platforms/44x/sequoia.c
> > +++ b/arch/powerpc/platforms/44x/sequoia.c
> > @@ -23,8 +23,6 @@
> >  #include <asm/uic.h>
> >  #include <asm/pci-bridge.h>
> >
> > -#include "44x.h"
> > -
>
> Almost a perfect patch.  Alas, missing a #include <asm/ppc4xx.h> which
> breaks the sequoia build.
>
> I'll fix it up locally :).

Thanks Josh. I missed that one.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
