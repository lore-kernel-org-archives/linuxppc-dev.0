Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id DEB66B6F18
 for <linuxppc-dev@ozlabs.org>; Sat,  3 Dec 2011 09:24:13 +1100 (EST)
Received: from mail132-ch1 (localhost [127.0.0.1])	by
 mail132-ch1-R.bigfish.com (Postfix) with ESMTP id 7B9061803DE	for
 <linuxppc-dev@ozlabs.org>; Fri,  2 Dec 2011 22:24:10 +0000 (UTC)
Received: from CH1EHSMHS021.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.254])	by mail132-ch1.bigfish.com (Postfix) with ESMTP id
 4C82646016F	for <linuxppc-dev@ozlabs.org>; Fri,  2 Dec 2011 22:24:08 +0000
 (UTC)
Message-ID: <4ED95006.9010301@freescale.com>
Date: Fri, 2 Dec 2011 16:24:06 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/85xx: add a 32-bit P1022DS device tree
References: <1322863714-6818-1-git-send-email-timur@freescale.com>
 <1322863714-6818-2-git-send-email-timur@freescale.com>
 <4ED94EF5.2090406@freescale.com>
In-Reply-To: <4ED94EF5.2090406@freescale.com>
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

> Please add something after post to strip simple-bus off of the localbus
> node's compatible.  Either you have board-control@0,0, or you have the
> other stuff (did you ever find out what the situation with NAND is?) --
> not both at the same time.  Or do you have U-Boot patching in status
> updates now?

I posted a Linux patch that disables the NOR flash node if video needs to be enabled. 

http://patchwork.ozlabs.org/patch/126459/

However, I only now notice that Kumar requested some changes.

-- 
Timur Tabi
Linux kernel developer at Freescale
