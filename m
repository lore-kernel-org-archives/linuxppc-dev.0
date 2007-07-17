Return-Path: <rongkai.zhan@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 13CC5DDE1E
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 00:29:47 +1000 (EST)
Subject: Re: [PATCH 2/3] 82xx: Parse SMC serial device node in DTS
From: Mark Zhan <rongkai.zhan@windriver.com>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200707171506.43102.arnd@arndb.de>
References: <469B33F9.2080604@windriver.com>
	<200707171406.03455.arnd@arndb.de> <1184680385.18501.51.camel@mark>
	<200707171506.43102.arnd@arndb.de>
Content-Type: text/plain
Date: Tue, 17 Jul 2007 22:29:35 +0800
Message-Id: <1184682576.18501.62.camel@mark>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-07-17 at 15:06 +0200, Arnd Bergmann wrote:
> On Tuesday 17 July 2007, Mark Zhan wrote:
> > Yes, basically I agree what you say. That should be the right way. 
> > 
> > but, the current situation is that: in all DTS files that are using smc
> > or scc as uart device, all device node definitions have the same
> > "compatible" property -- "cpm_uart"
> > 
> > So what I do here is just following the upstream source tree.
> > 
> 
> Well, AFAICS, all of them currently use scc. The 8xx platforms don't
> even build correctly in the mainline kernel, so I guess it would
> be good to change them to also list fsl,cpm-smc in the compatible
> property.

That probably could be done by another series of patches, and I really
don't want to introduce those kinds of patches in my BSP patches. I
don't know if the 8xx/82xx series patches from Scott Wood will cover
this issue or not. We can wait for them to see where thing will go.

Thanks
mark zhan
