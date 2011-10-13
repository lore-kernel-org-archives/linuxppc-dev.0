Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id C2B81B6FA5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2011 02:35:18 +1100 (EST)
Message-ID: <4E970528.8080908@freescale.com>
Date: Thu, 13 Oct 2011 10:35:04 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/85xx: fix PHYS_64BIT selection for P1022DS
References: <1316806370-21067-1-git-send-email-agust@denx.de>
 <6EFB6D12-7505-4D3E-8FF9-033EF74FFB81@kernel.crashing.org>
 <CAOZdJXUWiatadSCmCAvMRrVjVKCJb0xo+XGsF=Rz5-Smp08tMA@mail.gmail.com>
 <6F5815DD-DBF0-4155-94CE-FEDC2C9802E1@kernel.crashing.org>
In-Reply-To: <6F5815DD-DBF0-4155-94CE-FEDC2C9802E1@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Anatolij Gustschin <agust@denx.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala wrote:
>> > Why did you apply this patch?  Both Scott and I rejected it.

> Because its fixing a real issue.  If we want to remove PHYS_64BIT support or make it optional for the board feel free to send another patch.

Ok, so if someone posts a patch that works but does things the wrong way, and
that patch gets rejected during reviews, but the submitter doesn't post a
follow-up patch that does things the right way, you're going to apply the first
patch anyway?

What about the BSP team's contention that enabling 64-bit support in the kernel
can drop performance by up to 25% in some situations?  We talked about that on
an internal mailing list several months ago.

-- 
Timur Tabi
Linux kernel developer at Freescale
