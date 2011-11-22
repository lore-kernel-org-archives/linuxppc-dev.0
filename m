Return-Path: <dedekind1@gmail.com>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
 [209.85.160.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id C70E31007D4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2011 08:05:54 +1100 (EST)
Received: by ghrr19 with SMTP id r19so673260ghr.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2011 13:05:45 -0800 (PST)
Subject: Re: [PATCH 2/3] mtd/nand : set Nand flash page address to FBAR and
 FPAR correctly
From: Artem Bityutskiy <dedekind1@gmail.com>
To: LiuShuo <b35362@freescale.com>
Date: Tue, 22 Nov 2011 23:05:38 +0200
In-Reply-To: <4EC5BE16.9080205@freescale.com>
References: <1321349355-1639-1-git-send-email-b35362@freescale.com>
 <1321349355-1639-2-git-send-email-b35362@freescale.com>
 <1321568016.2272.29.camel@koala> <4EC5BE16.9080205@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321995943.2222.3.camel@koala>
Mime-Version: 1.0
Cc: Artem.Bityutskiy@nokia.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Tang Yuantian <b29983@freescale.com>,
 linux-mtd@lists.infradead.org, Jerry Huang <Chang-Ming.Huang@freescale.com>,
 scottwood@freescale.com, akpm@linux-foundation.org, dwmw2@infradead.org
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-11-18 at 10:08 +0800, LiuShuo wrote:
> Ok and I want to add another patch before 3/3.
> 
> -LiuShuo
> > On Tue, 2011-11-15 at 17:29 +0800, b35362@freescale.com wrote:
> >> From: Liu Shuo<b35362@freescale.com>
> >>
> >> If we use the Nand flash chip whose number of pages in a block is greater
> >> than 64(for large page), we must treat the low bit of FBAR as being the
> >> high bit of the page address due to the limitation of FCM, it simply uses
> >> the low 6-bits (for large page) of the combined block/page address as the
> >> FPAR component, rather than considering the actual block size.
> > Looks like this patch depends on the previous white-space clean-up patch
> > - could you please refactor it (and 3/3 too) and resend?
> Ok and I am going to add another new patch before 3/3.

Sure, send 3/3 as well because this one depends on the cleanup patch, so
cannot be applied independently.

Artem.
