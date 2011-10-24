Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 372B5B6F87
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Oct 2011 01:09:06 +1100 (EST)
Message-ID: <4EA570AB.7040704@freescale.com>
Date: Mon, 24 Oct 2011 09:05:31 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 03/11] powerpc/85xx: Rework PCI nodes on P1020RDB
References: <1319318452-27036-1-git-send-email-galak@kernel.crashing.org>
 <1319318452-27036-2-git-send-email-galak@kernel.crashing.org>
 <1319318452-27036-3-git-send-email-galak@kernel.crashing.org>
 <CAOZdJXUy5qDhbEAih2kx91fmgyxqd7u9T6AV4fDvp4AMMRA+4w@mail
 <49F9A823-B7C3-4D53-A061-8AC1C8D22554@kernel.crashing.org>
In-Reply-To: <49F9A823-B7C3-4D53-A061-8AC1C8D22554@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> I would have hoped the bindings had made it clear already what was board info vs what was SoC.

When it comes to device trees, I never assume anything is "clear".

> If not, they should be clarify that in the binding specs.

I'm okay with that.

-- 
Timur Tabi
Linux kernel developer at Freescale
