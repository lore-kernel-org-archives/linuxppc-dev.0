Return-Path: <SRS0+610955aeb5ed8db29aac+455+infradead.org+dwmw2@canuck.srs.infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [205.233.218.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5C8BB2BDB5
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Nov 2004 06:35:07 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: Sean Neakums <sneakums@zork.net>
In-Reply-To: <6ubrdsjiq1.fsf@zork.zork.net>
References: <6ubrdsjiq1.fsf@zork.zork.net>
Content-Type: text/plain
Date: Sun, 21 Nov 2004 19:34:44 +0000
Message-Id: <1101065685.9988.49.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: TEST: Sleep suppport for iBook G4 & Aluminium PowerBooks (ATI
	based)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2004-11-20 at 21:47 +0000, Sean Neakums wrote:
> > http://gate.crashing.org/~benh/albook-ibookg4-sleep-2.diff
> 
> I tried this on my 15" AlBook (one of the new 1.5GHz ones), applied to
> Debian's 2.6.9.  It suspended and resumed fine (and quickly!), but
> after resume I noticed that images (in Mozilla and the root window)
> would become corrupted if obscured and made visible again, e.g. by
> switching tabs, or by moving between a full and an empty workspace.

I've seen similar behaviour in firefox on a 17" AlBook with Fedora Core
3. I can't remember if it was with Ben's first or second patch. Neither
can I reproduce it now with the second version.

-- 
dwmw2
