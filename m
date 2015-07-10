Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0109.outbound.protection.outlook.com [157.56.111.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CB88A1A0018
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jul 2015 04:50:42 +1000 (AEST)
Message-ID: <1436554227.2658.161.camel@freescale.com>
Subject: Re: [PATCH 02/11] soc/fsl: Introduce DPAA BMan device management
 driver
From: Scott Wood <scottwood@freescale.com>
To: Pledge Roy-R01356 <roy.pledge@freescale.com>
CC: Paul Bolle <pebolle@tiscali.nl>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Fri, 10 Jul 2015 13:50:27 -0500
In-Reply-To: <BN3PR0301MB1267E9EFD8CBC294275028B68C9F0@BN3PR0301MB1267.namprd03.prod.outlook.com>
References: <1436473322-21247-1-git-send-email-Roy.Pledge@freescale.com>
 <1436473322-21247-3-git-send-email-Roy.Pledge@freescale.com>
 <1436517510.20619.123.camel@tiscali.nl>
 <1436549503.2658.157.camel@freescale.com>
 <BN3PR0301MB1267E9EFD8CBC294275028B68C9F0@BN3PR0301MB1267.namprd03.prod.outlook.com>
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

On Fri, 2015-07-10 at 13:29 -0500, Pledge Roy-R01356 wrote:
> >   return in_be32((void *)bm + offset);
> > >          ^
> > > [...]/drivers/soc/fsl/qbman/bman.c: In function ‘__bm_out’:
> > > [...]/drivers/soc/fsl/qbman/bman.c:172:2: error: implicit declaration
> > > of function ‘out_be32’ [-Werror=implicit-function-declaration]
> > >   out_be32((void *)bm + offset, val);
> > 
> > These PPCisms will need to be fixed.  LS1043A is an ARM chip with DPAA 
> > 1.0.
> 
> LS1043 (ARM, Little Endian) support is still work in progress.  The patches 
> for that are being tested now but are based on the SDK version of the 
> driver and will need to be massaged in order to get them applied here.  Our 
> plan of record is to add upstream support for this at a later time.

If you're already reworking this for upstream acceptance, why not fix the 
more obvious PPCisms now?

-Scott
