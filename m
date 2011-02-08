Return-Path: <timur@freescale.com>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C82E3B70B3
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Feb 2011 03:33:31 +1100 (EST)
Message-ID: <4D517052.7050003@freescale.com>
Date: Tue, 8 Feb 2011 10:33:22 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] watchdog: booke_wdt: clean up status messages
References: <1295299780-27338-1-git-send-email-timur@freescale.com>
	<1297040772.14982.25.camel@pasglop>
In-Reply-To: <1297040772.14982.25.camel@pasglop>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, wim@iguana.be, linux-watchdog@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> If you're going to cleanup the messages, then I think displaying:
> 
> PowerPC Book-E Watchdog Timer Loaded
> booke_wdt: watchdog enabled (timeout = xxx sec)
> 
> Isn't very nice.
> 
> Lacks consistency ... you can prefix both lines the same way, or
> maybe better print only one line with all the necessary info.

Yeah, I see your point.  I'll post a v2.

-- 
Timur Tabi
Linux kernel developer at Freescale
