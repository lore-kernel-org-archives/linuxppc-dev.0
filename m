Return-Path: <dedekind1@gmail.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
 [209.85.214.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 1825EB720E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2011 09:13:42 +1100 (EST)
Received: by bkat8 with SMTP id t8so2627562bka.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2011 14:13:38 -0800 (PST)
Subject: Re: [PATCH 2/3] mtd/nand : set Nand flash page address to FBAR and
 FPAR correctly
From: Artem Bityutskiy <dedekind1@gmail.com>
To: b35362@freescale.com
Date: Fri, 18 Nov 2011 00:13:34 +0200
In-Reply-To: <1321349355-1639-2-git-send-email-b35362@freescale.com>
References: <1321349355-1639-1-git-send-email-b35362@freescale.com>
 <1321349355-1639-2-git-send-email-b35362@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321568016.2272.29.camel@koala>
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

On Tue, 2011-11-15 at 17:29 +0800, b35362@freescale.com wrote:
> From: Liu Shuo <b35362@freescale.com>
> 
> If we use the Nand flash chip whose number of pages in a block is greater
> than 64(for large page), we must treat the low bit of FBAR as being the
> high bit of the page address due to the limitation of FCM, it simply uses
> the low 6-bits (for large page) of the combined block/page address as the
> FPAR component, rather than considering the actual block size.

Looks like this patch depends on the previous white-space clean-up patch
- could you please refactor it (and 3/3 too) and resend?

Artem.
