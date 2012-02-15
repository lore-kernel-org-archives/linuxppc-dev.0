Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: McClintock Matthew-B29882 <B29882@freescale.com>
Subject: Re: Build fail in hugetlbpage.c with linux-next and mpc85xx_defconfig
In-reply-to: <CAEsOVNcpBLmsmyZLW2HNe3MDR5cx5oJnPMmGD6Mqz4AjG16=9A@mail.gmail.com>
References: <14174.1329347321@neuling.org>
 <CAEsOVNcpBLmsmyZLW2HNe3MDR5cx5oJnPMmGD6Mqz4AjG16=9A@mail.gmail.com>
Date: Thu, 16 Feb 2012 10:37:43 +1100
Message-ID: <16098.1329349063@neuling.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > Becky,
> >
> > This has been broken in linux-next for a while. =A0Looks like a merge
> > issue but you were the last to touch it...
> >
> > arch/powerpc/mm/hugetlbpage.c: In function 'reserve_hugetlb_gpages':
> > arch/powerpc/mm/hugetlbpage.c:313: error: passing argument 5 of 'parse_ar=
> gs' makes integer from pointer without a cast
> > include/linux/moduleparam.h:317: note: expected 's16' but argument is of =
> type 'int (*)(char *, char *)'
> > arch/powerpc/mm/hugetlbpage.c:313: error: too few arguments to function '=
> parse_args'
> 
> A suggest fix has been submitted.

Do you have a link?  Which tree is it going in?

Mikey
