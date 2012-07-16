Return-Path: <B04825@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 37C542C010E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2012 06:31:11 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: "lu.jiang@windriver.com" <lu.jiang@windriver.com>
Subject: Re: [PATCH] ppc44x/watchdog: Select WATCHDOG_NOWAYOUT option
Date: Mon, 16 Jul 2012 20:30:37 +0000
Message-ID: <CAOZdJXWcW4vTMDMgkoJdLFVvAPnP-0pa6icFd1sEXcLTLJ4qag@mail.gmail.com>
References: <1342147473-20231-1-git-send-email-lu.jiang@windriver.com>
 <D5792F52-7BE6-4B86-A3FD-B756DE3A165D@kernel.crashing.org>
 <50037762.4000800@windriver.com>
In-Reply-To: <50037762.4000800@windriver.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jul 15, 2012 at 9:07 PM, Lu.Jiang <lu.jiang@windriver.com> wrote:
>
> Since the ppc44x's watch dog can not reset by software, such operation on=
ly
> set the timeout value(WDTP) to minimum, and cause the system reboot
> immediately.

It's supposed to set it to the maximum.  That's what WDTP_MASK is
supposed to do.

--=20
Timur Tabi
Linux kernel developer at Freescale=
