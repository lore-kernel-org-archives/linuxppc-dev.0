Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0131.outbound.protection.outlook.com [65.55.169.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 30AB71A004D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:13:59 +1000 (AEST)
Message-ID: <1433398423.3415.34.camel@freescale.com>
Subject: Re: [PATCH 2/2] rheap: move rheap.c from arch/powerpc/lib/ to lib/
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang-B45475 <qiang.zhao@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Xie
 Xiaobo-R63061" <X.Xie@freescale.com>
Date: Thu, 4 Jun 2015 01:13:43 -0500
In-Reply-To: <SN1PR0301MB15500729CC3A65394FED67389BB30@SN1PR0301MB1550.namprd03.prod.outlook.com>
References: <1432717920-43563-1-git-send-email-B45475@freescale.com>
 <1432717920-43563-2-git-send-email-B45475@freescale.com>
 <1432748213.4089.23.camel@freescale.com>
 <SN1PR0301MB15500729CC3A65394FED67389BB30@SN1PR0301MB1550.namprd03.prod.outlook.com>
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

On Thu, 2015-06-04 at 00:56 -0500, Zhao Qiang-B45475 wrote:
> On Thu, 2015-05-28 at 1:37AM +0800, Wood Scott wrote:
> 
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Thursday, May 28, 2015 1:37 AM
> > To: Zhao Qiang-B45475
> > Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421; Xie Xiaobo-
> > R63061
> > Subject: Re: [PATCH 2/2] rheap: move rheap.c from 
> > arch/powerpc/lib/ to
> > lib/
> > 
> > On Wed, 2015-05-27 at 17:12 +0800, Zhao Qiang wrote:
> > > qe need to use the rheap, so move it to public directory.
> > 
> > You've been previously asked to use lib/genalloc.c rather than 
> > introduce
> > duplicate functionality into /lib.  NACK.
> 
> Can't use lib/genalloc.c instead of rheap.c.
> Qe need to alloc muram of qe, not DIMM.

lib/genalloc.h is not for allocating main memory.  It is for 
allocating special regions.  It is serving the same purpose as rheap.

-Scott
