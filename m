Return-Path: <B04825@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0C9812C0091
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2012 02:50:06 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Wang Dongsheng <dongsheng.wds@gmail.com>
Subject: Re: [PATCH] powerpc/mpic: add global timer support
Date: Thu, 13 Dec 2012 15:49:57 +0000
Message-ID: <6AE080B68D46FC4BA2D2769E68D765B7081CDEEC@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1349260710-15718-1-git-send-email-dongsheng.wds@gmail.com>
In-Reply-To: <1349260710-15718-1-git-send-email-dongsheng.wds@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Wang Dongsheng-B40534 <B40534@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 3, 2012 at 5:38 AM, Wang Dongsheng <dongsheng.wds@gmail.com> wr=
ote:

> diff --git a/arch/powerpc/include/asm/mpic_timer.h b/arch/powerpc/include=
/asm/mpic_timer.h
> new file mode 100644
> index 0000000..2428972
> --- /dev/null
> +++ b/arch/powerpc/include/asm/mpic_timer.h
> @@ -0,0 +1,39 @@
> +/*
> + * arch/powerpc/include/asm/mpic_timer.h
> + *
> + * Mpic Global Timer Header
> + *
> + * Copyright 2012 Freescale Semicondutor, Inc.

When this patch is applied, please fix the misspelling of "Semiconductor".

--=20
Timur Tabi
Linux kernel developer at Freescale=
