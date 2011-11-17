Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 084B6B722B
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2011 09:28:54 +1100 (EST)
Received: from mail19-ch1 (localhost [127.0.0.1])	by mail19-ch1-R.bigfish.com
 (Postfix) with ESMTP id AED484A02A2	for <linuxppc-dev@ozlabs.org>;
 Thu, 17 Nov 2011 22:28:46 +0000 (UTC)
Received: from CH1EHSMHS033.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.254])	by mail19-ch1.bigfish.com (Postfix) with ESMTP id
 96741700046
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2011 22:28:46 +0000 (UTC)
Message-ID: <4EC58AA0.2070905@freescale.com>
Date: Thu, 17 Nov 2011 16:28:48 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/85xx: p1022ds: enable monitor switching via
 pixis indirect mode
References: <1321556259-4459-1-git-send-email-timur@freescale.com>
 <1321556259-4459-2-git-send-email-timur@freescale.com>
 <20111117213733.GC14736@schlenkerla.am.freescale.net>
 <4EC586B2.5060604@freescale.com>
 <20111117222515.GA18827@schlenkerla.am.freescale.net>
In-Reply-To: <20111117222515.GA18827@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:

> As we discussed earlier, you could have a kernel boot parameter that
> indicates what mode you'd like the localbus to run in.  Then, platform
> code could update the device tree before any drivers bind.

How do I update the device tree from platform code?

> Or, have U-boot set up the desired mode before entering the kernel, and
> provide an appropriate device tree.

I can both of these features, but not in this patch.

-- 
Timur Tabi
Linux kernel developer at Freescale
