Return-Path: <sneakums@zork.net>
Received: from zork.zork.net (zork.zork.net [64.81.246.102])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 493C42BEA0
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Nov 2004 09:03:46 +1100 (EST)
To: benh@kernel.crashing.org
From: Sean Neakums <sneakums@zork.net>
Date: Sat, 20 Nov 2004 21:47:34 +0000
Message-ID: <6ubrdsjiq1.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

> http://gate.crashing.org/~benh/albook-ibookg4-sleep-2.diff

I tried this on my 15" AlBook (one of the new 1.5GHz ones), applied to
Debian's 2.6.9.  It suspended and resumed fine (and quickly!), but
after resume I noticed that images (in Mozilla and the root window)
would become corrupted if obscured and made visible again, e.g. by
switching tabs, or by moving between a full and an empty workspace.
