Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 124542BDB5
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Nov 2004 09:22:49 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sean Neakums <sneakums@zork.net>
In-Reply-To: <6ubrdsjiq1.fsf@zork.zork.net>
References: <6ubrdsjiq1.fsf@zork.zork.net>
Content-Type: text/plain
Date: Sun, 21 Nov 2004 09:22:19 +1100
Message-Id: <1100989339.3795.6.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
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

Do you have APM emulation enabled in the kenrel config and do you
have /dev/apm_bios ? (check in X log that it properly opens the APM
device and gets notified of suspend and resume events).

Ben.
