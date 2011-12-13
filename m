Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 1C6C81007D3
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Dec 2011 11:27:33 +1100 (EST)
Received: from mail154-ch1 (localhost [127.0.0.1])	by
 mail154-ch1-R.bigfish.com (Postfix) with ESMTP id D419F2A0580	for
 <linuxppc-dev@ozlabs.org>; Tue, 13 Dec 2011 00:27:25 +0000 (UTC)
Received: from CH1EHSMHS025.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.242])	by mail154-ch1.bigfish.com (Postfix) with ESMTP id
 BD47EC0052
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Dec 2011 00:27:23 +0000 (UTC)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: Re: [PATCH] powerpc/fsl: add MSI support for the Freescale hypervisor
Date: Tue, 13 Dec 2011 00:27:25 +0000
Message-ID: <4EE69BEB.8020208@freescale.com>
References: <1323733052-21495-1-git-send-email-timur@freescale.com>
 <4EE693C9.3080009@freescale.com>
In-Reply-To: <4EE693C9.3080009@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Technically, it's up to the hv config file where MSIIR gets mapped.
> After main memory is just a common way of configuring it, but won't work
> if we're limiting the partition's memory to end at an unusual address.

I'll change the comment to reflect this.

Why can't we have the hypervisor always put MSIIR at the end of DDR, and=20
not make it configurable?

--=20
Timur Tabi
Linux kernel developer at Freescale=
