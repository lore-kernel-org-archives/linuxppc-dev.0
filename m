Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0147.outbound.protection.outlook.com [65.55.169.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7658B1A0748
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 04:54:45 +1000 (AEST)
Message-ID: <1438714472.2097.89.camel@freescale.com>
Subject: Re: GPMC in device tree
From: Scott Wood <scottwood@freescale.com>
To: Ran Shalit <ranshalit@gmail.com>
CC: <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 4 Aug 2015 13:54:32 -0500
In-Reply-To: <CAJ2oMhJgnPGUPKRGBXZALYcrn+sL8Nt0A6gfPN+Ei_c+06mUPg@mail.gmail.com>
References: <CAJ2oMhJgnPGUPKRGBXZALYcrn+sL8Nt0A6gfPN+Ei_c+06mUPg@mail.gmail.com>
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

On Tue, 2015-08-04 at 18:29 +0300, Ran Shalit wrote:
> Hello,
> 
> I would please like to ask if describing flash nor used with GPMC,
> whould be done as described in:
> https://www.kernel.org/doc/Documentation/devicetree/bindings/mtd/gpmc-nor.txt
> It is described in the above link as "TI's GPMC", so I'm not sure if
> it is relevent for powerpc too.

That binding is for TI GPMC.

Are you saying you have some PPC chip that has a flash controller called GPMC?

-Scott
