Return-Path: <sneakums@zork.net>
Received: from zork.zork.net (zork.zork.net [64.81.246.102])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 990C62BE83
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Nov 2004 10:26:08 +1100 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <6ubrdsjiq1.fsf@zork.zork.net> <1100989339.3795.6.camel@gaston>
	<6u7jogjg8t.fsf@zork.zork.net> <1100991146.3795.17.camel@gaston>
	<6uy8gwi0qz.fsf@zork.zork.net>
From: Sean Neakums <sneakums@zork.net>
Date: Sat, 20 Nov 2004 23:25:57 +0000
In-Reply-To: <6uy8gwi0qz.fsf@zork.zork.net> (Sean Neakums's message of "Sat,
	20 Nov 2004 23:01:08 +0000")
Message-ID: <6uu0rkhzlm.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Sean Neakums <sneakums@zork.net> writes:

> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>> Does it still happen if you disable dynamic clocks ?
>> (radeonfb.default_dynclk=-1 on the kernel cmdline and Option
>> "DynamicClocks" "false" in X if you are using X.org). And if you
>> disable accel in X ? (Option "NoAccel" "true")
>
> I'll try these out.

With radeonfb.default_dynclk=-1 alone (using Debian's XFree86 4.3.0,
so no Option "DynamicClocks" "false"), the corruption is slower to
progress, but seems to be the same as the corruption seen with dynamic
clocks enabled.

With NoAccel alone, I do not yet see any corruption; I would expect to
have seen it by now, going by the previous tests.
