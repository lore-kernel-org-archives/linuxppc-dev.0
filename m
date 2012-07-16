Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 075A62C010B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2012 06:28:13 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [PATCH] ppc44x/watchdog: Select WATCHDOG_NOWAYOUT option
Date: Mon, 16 Jul 2012 20:28:02 +0000
Message-ID: <CAOZdJXVMdr4MzH56FLKaQCk5FAfSpEQ9crka93djeMiU3s_FtA@mail.gmail.com>
References: <1342147473-20231-1-git-send-email-lu.jiang@windriver.com>
 <D5792F52-7BE6-4B86-A3FD-B756DE3A165D@kernel.crashing.org>
 <CA+5PVA6RG1m8c2OUL2g0gBK7dRCrmeu47rZfoqAjxODm1zcNRg@mail.gmail.com>
In-Reply-To: <CA+5PVA6RG1m8c2OUL2g0gBK7dRCrmeu47rZfoqAjxODm1zcNRg@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Jiang Lu <lu.jiang@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 13, 2012 at 7:25 AM, Josh Boyer <jwboyer@gmail.com> wrote:

> Right now, if the option is not set we call booke_wdt_disable which
> indeed does not actually _disable_ the WDT, but it does set the timer
> period to the maxium value.  We could go one step further and implement
> a simple timer that pops and calls booke_wdt_ping if WATCHDOG_NOWAYOUT
> is not set, then rearms itself.  That would leave the user with the
> ability to perform recovery of the userspace process that exited or
> died and was responsible for pinging the watchdog.

I think the maximum value is still decades or centuries, so there's no
real reason to complicate the code.

The NOWAYOUT feature is working as designed, so I don't understand the
need for this patch.

--=20
Timur Tabi
Linux kernel developer at Freescale=
