Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E678DDDF51
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 04:44:17 +1100 (EST)
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 3/7] Basic Freescale MPC512x support 
In-Reply-To: Your message of "Tue, 08 Jan 2008 11:40:38 CST."
	<20080108174038.GA20819@lixom.net>
References: <1199808093-15929-1-git-send-email-jrigby@freescale.com>
	<1199808093-15929-2-git-send-email-jrigby@freescale.com>
	<1199808093-15929-3-git-send-email-jrigby@freescale.com>
	<1199808093-15929-4-git-send-email-jrigby@freescale.com>
	<20080108174038.GA20819@lixom.net>
Date: Tue, 08 Jan 2008 11:44:11 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1JCIUl-0008EX-Du@jdl.com>
Cc: linuxppc-dev@ozlabs.org, John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Olof Johansson mumbled:
> 
> > @@ -0,0 +1,90 @@
> > +#include <asm/system.h>
> > +#include <asm/atomic.h>
> > +#include <asm/machdep.h>
> > +#include <asm/ipic.h>
> > +#include <asm/prom.h>
> > +#include <asm/time.h>
> > +#include <asm/of_platform.h>
> 
> Stephen will tell you to include linux/of_platform.h instead. :-)

Yeah, watch me outright NAK it too. :-)

jdl
