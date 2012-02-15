Return-Path: <B29882@freescale.com>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe004.messaging.microsoft.com
 [65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2C8411007D7
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Feb 2012 10:32:25 +1100 (EST)
From: McClintock Matthew-B29882 <B29882@freescale.com>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: Build fail in hugetlbpage.c with linux-next and mpc85xx_defconfig
Date: Wed, 15 Feb 2012 23:32:14 +0000
Message-ID: <CAEsOVNcpBLmsmyZLW2HNe3MDR5cx5oJnPMmGD6Mqz4AjG16=9A@mail.gmail.com>
References: <14174.1329347321@neuling.org>
In-Reply-To: <14174.1329347321@neuling.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Reply-To: McClintock Matthew-B29882 <B29882@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 15, 2012 at 11:08 PM, Michael Neuling <mikey@neuling.org> wrote=
:
> Becky,
>
> This has been broken in linux-next for a while. =A0Looks like a merge
> issue but you were the last to touch it...
>
> arch/powerpc/mm/hugetlbpage.c: In function 'reserve_hugetlb_gpages':
> arch/powerpc/mm/hugetlbpage.c:313: error: passing argument 5 of 'parse_ar=
gs' makes integer from pointer without a cast
> include/linux/moduleparam.h:317: note: expected 's16' but argument is of =
type 'int (*)(char *, char *)'
> arch/powerpc/mm/hugetlbpage.c:313: error: too few arguments to function '=
parse_args'

A suggest fix has been submitted.

-M=
