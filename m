Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
 [65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 355CEB6F92
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2011 01:14:25 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/85xx: fix PHYS_64BIT selection for P1022DS
Date: Thu, 13 Oct 2011 14:14:11 +0000
Message-ID: <CAOZdJXUWiatadSCmCAvMRrVjVKCJb0xo+XGsF=Rz5-Smp08tMA@mail.gmail.com>
References: <1316806370-21067-1-git-send-email-agust@denx.de>
 <6EFB6D12-7505-4D3E-8FF9-033EF74FFB81@kernel.crashing.org>
In-Reply-To: <6EFB6D12-7505-4D3E-8FF9-033EF74FFB81@kernel.crashing.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
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

On Tue, Oct 11, 2011 at 11:53 PM, Kumar Gala <galak@kernel.crashing.org> wr=
ote:
>
> On Sep 23, 2011, at 2:32 PM, Anatolij Gustschin wrote:
>
>> Remove wrong CONFIG_ prefix in Kconfig file.
>>
>> Signed-off-by: Anatolij Gustschin <agust@denx.de>
>> ---
>> arch/powerpc/platforms/85xx/Kconfig | =A0 =A02 +-
>> 1 files changed, 1 insertions(+), 1 deletions(-)
>
> applied

Why did you apply this patch?  Both Scott and I rejected it.

--=20
Timur Tabi
Linux kernel developer at Freescale=
