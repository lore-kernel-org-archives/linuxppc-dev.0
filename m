Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
 [213.199.154.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 028181007D7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Dec 2011 09:05:25 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Becky Bruce <beckyb@kernel.crashing.org>
Subject: Re: [PATCH 10/13] powerpc: Update mpc85xx/corenet 32-bit defconfigs
Date: Fri, 9 Dec 2011 22:05:14 +0000
Message-ID: <CAOZdJXXWE8FJg7UAQ4-sCFZcmUq3+2+kF=MCtF4muWaQQDyQ=Q@mail.gmail.com>
References: <1318279848494-git-send-email-beckyb@kernel.crashing.org>
 <13182798624083-git-send-email-beckyb@kernel.crashing.org>
 <13182798643553-git-send-email-beckyb@kernel.crashing.org>
 <13182798681100-git-send-email-beckyb@kernel.crashing.org>
 <1318279870278-git-send-email-beckyb@kernel.crashing.org>
 <13182798731357-git-send-email-beckyb@kernel.crashing.org>
 <13182798761457-git-send-email-beckyb@kernel.crashing.org>
 <13182798791090-git-send-email-beckyb@kernel.crashing.org>
 <1318279883564-git-send-email-beckyb@kernel.crashing.org>
 <1318279885811-git-send-email-beckyb@kernel.crashing.org>
 <13182798883685-git-send-email-beckyb@kernel.crashing.org>
In-Reply-To: <13182798883685-git-send-email-beckyb@kernel.crashing.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 10, 2011 at 3:50 PM, Becky Bruce <beckyb@kernel.crashing.org> w=
rote:
> From: Becky Bruce <beckyb@kernel.crashing.org>
>
> Results from updates via make savedefconfig.
>
> Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
> ---

...

> -CONFIG_PPC_EPAPR_HV_BYTECHAN=3Dy

I guess no one noticed that this patch removes byte channel support,
thereby preventing this kernel from booting under the hypervisor?

--=20
Timur Tabi
Linux kernel developer at Freescale=
