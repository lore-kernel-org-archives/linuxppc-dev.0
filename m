Return-Path: <B04825@freescale.com>
Received: from AM1EHSOBE004.bigfish.com (am1ehsobe004.messaging.microsoft.com
 [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id C206FB6F70
 for <linuxppc-dev@ozlabs.org>; Sat, 10 Dec 2011 06:28:04 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix compiliation with hugetlbfs enabled
Date: Fri, 9 Dec 2011 19:27:57 +0000
Message-ID: <CAOZdJXXTjm16gfaEOeQQY-zJEnwOyxdi61qMtpUzuB1u6=uHcA@mail.gmail.com>
References: <1322163607-4881-1-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1322163607-4881-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 24, 2011 at 1:40 PM, Kumar Gala <galak@kernel.crashing.org> wro=
te:
> arch/powerpc/mm/hugetlbpage.c: In function 'reserve_hugetlb_gpages':
> arch/powerpc/mm/hugetlbpage.c:312:2: error: implicit declaration of funct=
ion 'parse_args'
>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Acked-by: Timur Tabi <timur@freescale.com>

Would you please apply this to your 'next' branch?  It won't compile
with this patch.

--=20
Timur Tabi
Linux kernel developer at Freescale=
