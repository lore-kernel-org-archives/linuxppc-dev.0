Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7019AB71A5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Feb 2012 03:38:57 +1100 (EST)
Received: from mail153-ch1 (localhost [127.0.0.1])	by
 mail153-ch1-R.bigfish.com (Postfix) with ESMTP id 2B2453600D6	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2012 16:38:52 +0000 (UTC)
Received: from CH1EHSMHS028.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.249])	by mail153-ch1.bigfish.com (Postfix) with ESMTP id
 3E776140045	for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2012 16:38:49
 +0000 (UTC)
Message-ID: <4F32A509.3050108@freescale.com>
Date: Wed, 8 Feb 2012 10:38:33 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jia Hongtao <B38951@freescale.com>
Subject: Re: [linuxppc-release] [PATCH 1/2] powerpc/85xx: Change style of
 partition nodes in dts for MPC8572DS
References: <1328693276-12057-1-git-send-email-B38951@freescale.com>
In-Reply-To: <1328693276-12057-1-git-send-email-B38951@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jia Hongtao wrote:
> -			read-only;
> +			label = "ramdisk-nor";

This is not a "style change".  Please explain this patch better.

-- 
Timur Tabi
Linux kernel developer at Freescale
