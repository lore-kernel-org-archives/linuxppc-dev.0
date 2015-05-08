Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 169CC1A0862
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 May 2015 07:36:10 +1000 (AEST)
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0104.outbound.protection.outlook.com [65.55.169.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 31C091400B7
 for <linuxppc-dev@ozlabs.org>; Sat,  9 May 2015 07:36:08 +1000 (AEST)
Message-ID: <1431120952.16357.455.camel@freescale.com>
Subject: Re: [PATCH] powerpc/mpc85xx: Fix EDAC address capture
From: Scott Wood <scottwood@freescale.com>
To: songwenbin <Wenbin.Song@freescale.com>
Date: Fri, 8 May 2015 16:35:52 -0500
In-Reply-To: <1431120849.16357.453.camel@freescale.com>
References: <1430989491-23817-1-git-send-email-Wenbin.Song@freescale.com>
 <1431120849.16357.453.camel@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Mingkai.hu@freescale.com,
 York Sun <yorksun@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-05-08 at 16:34 -0500, Scott Wood wrote:
> On Thu, 2015-05-07 at 17:04 +0800, songwenbin wrote:
> > From: York Sun <yorksun@freescale.com>
> > 
> > Extend err_addr to cover 64 bits for DDR errors.
> > 
> > Signed-off-by: York Sun <yorksun@freescale.com>
> > Change-Id: Idb112c4a106416a9cad9933c415e6f62de5cf07b
> > Reviewed-on: http://git.am.freescale.net:8181/553
> > Tested-by: Schmitt Richard-B43082 <B43082@freescale.com>
> > Reviewed-by: Fleming Andrew-AFLEMING <AFLEMING@freescale.com>
> > Tested-by: Fleming Andrew-AFLEMING <AFLEMING@freescale.com>
> > Signed-off-by: songwenbin <wenbin.song@freescale.com>
> 
> Please don't include gerrit stuff in upstream submissions.  Definitely
> don't include "Reviewed-by/Tested-by" from gerrit as those approvals are
> from an entirely different context.

Never mind, I see you fixed that in v2. :-)

That said, these patches should go via the edac tree (see MAINTAINERS).

-Scott
