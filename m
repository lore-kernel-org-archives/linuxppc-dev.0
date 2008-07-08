Return-Path: <monstr@seznam.cz>
Received: from mxl.seznam.cz (mxl.seznam.cz [77.75.72.44])
	by ozlabs.org (Postfix) with ESMTP id B7570DDEFE
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 16:30:46 +1000 (EST)
Message-ID: <48730695.5010004@seznam.cz>
Date: Tue, 08 Jul 2008 08:17:57 +0200
From: Michal Simek <monstr@seznam.cz>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 31/60] microblaze_v4: memory inicialization, MMU, TLB
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>	<1214483429-32360-31-git-send-email-monstr@seznam.cz>	<1214483429-32360-32-git-send-email-monstr@seznam.cz>
	<200806261714.12967.arnd@arndb.de>
In-Reply-To: <200806261714.12967.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-2
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
	vapier.adi@gmail.com, matthew@wil.cx,
	microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org,
	John.Linn@xilinx.com, linuxppc-dev@ozlabs.org,
	will.newton@gmail.com, john.williams@petalogix.com,
	hpa@zytor.com, drepper@redhat.com, alan@lxorguk.ukuu.org.uk
Reply-To: monstr@seznam.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Arnd,

> On Thursday 26 June 2008, monstr@seznam.cz wrote:
> 
>> +#include <linux/autoconf.h>
> 
> You should never need to include linux/autoconf.h anywhere,
> just remove this.

Remove from all files

>> +#include <linux/init.h>
>> +#include <linux/mm.h>
>> +#include "../../../mm/internal.h"
> 
> Why do you need to include the internal.h file here?
> If you have a good reason to do it, you should probably
> add the symbol you need to a global header file.

There was reason for doing it in older version. With current
version work without internal.h.

Thank for comment,
Michal



> 	Arnd <><
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 
> ------------------------------------------------------------------------
> 
> 
> No virus found in this incoming message.
> Checked by AVG. 
> Version: 8.0.101 / Virus Database: 270.4.1/1519 - Release Date: 25.6.2008 04:13
