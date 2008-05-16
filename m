Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id A3173DDE0D
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 15:03:07 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] 4xx: Workaround for CHIP_11 Errata
Date: Fri, 16 May 2008 06:57:00 +0200
References: <20080515094346.3338e1f3@zod.rchland.ibm.com>
	<20080515163104.18f0a613@lappy.seanm.ca>
	<20080515160734.4e4ea759@zod.rchland.ibm.com>
In-Reply-To: <20080515160734.4e4ea759@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200805160657.00300.sr@denx.de>
Cc: Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 15 May 2008, Josh Boyer wrote:
> > "Josh Boyer" <jwboyer@linux.vnet.ibm.com> wrote:
> > > This implements the recommended workaround for this errata for chips
> > > that use older versions of firmware that do not already handle it.
> > > The last 4KiB of memory are hidden from the kernel to prevent the
> > > problem transactions from occurring.
> >
> > Do you know which versions of firmware have this problem?
>
> Any U-Boot older than 1.3.3-rc1.  Not sure about PIBS, but I don't
> think the version that is on my Bamboo board has a fix for it.

PIBS will definitely have this problem too. This errata is quite new on 
440EP/GR.

Best regards,
Stefan
