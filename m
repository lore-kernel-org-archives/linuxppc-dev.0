Return-Path: <B04825@freescale.com>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
 [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id CE6A1B7376
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2011 02:45:19 +1100 (EST)
Message-ID: <4E970780.7000100@freescale.com>
Date: Thu, 13 Oct 2011 10:45:04 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/85xx: fix PHYS_64BIT selection for P1022DS
References: <1316806370-21067-1-git-send-email-agust@denx.de>
 <6EFB6D12-7505-4D3E-8FF9-033EF74FFB81@kernel.crashing.org>
 <CAOZdJXUWiatadSCmCAvMRrVjVKCJb0xo+XGsF=Rz5-Smp08tMA@mail.gmail.com>
 <6F5815DD-DBF0-4155-94CE-FEDC2C9802E1@kernel.crashing.org>
 <4E970528.8080908@freescale.com>
 <E8940641-D5F9-4ADE-8892-387BB221AD71@kernel.crashing.org>
In-Reply-To: <E8940641-D5F9-4ADE-8892-387BB221AD71@kernel.crashing.org>
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
> I think this 25% number is bogus.  There are cases where it also improves performance.

I don't think we ever ship a P1022 system with more than 2GB of DDR, so I can't
see how performance is ever improved.

I will post a patch that removes the Kconfig option, but I don't understand why
you couldn't do that when you applied the patch.

-- 
Timur Tabi
Linux kernel developer at Freescale
