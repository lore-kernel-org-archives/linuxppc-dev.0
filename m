Return-Path: <dedekind1@gmail.com>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
 [209.85.215.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 60D9E1007D4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2011 08:04:38 +1100 (EST)
Received: by lago2 with SMTP id o2so414120lag.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Dec 2011 13:04:33 -0800 (PST)
Subject: Re: [PATCH 1/2] mtd/nand : set Nand flash page address to FBAR and
 FPAR correctly
From: Artem Bityutskiy <dedekind1@gmail.com>
To: shuo.liu@freescale.com
Date: Mon, 12 Dec 2011 23:04:25 +0200
In-Reply-To: <1323423775-26951-1-git-send-email-shuo.liu@freescale.com>
References: <1323423775-26951-1-git-send-email-shuo.liu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1323723871.2297.9.camel@koala>
Mime-Version: 1.0
Cc: Artem.Bityutskiy@nokia.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
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

On Fri, 2011-12-09 at 17:42 +0800, shuo.liu@freescale.com wrote:
> From: Liu Shuo <b35362@freescale.com>
> 
> If we use the Nand flash chip whose number of pages in a block is greater
> than 64(for large page), we must treat the low bit of FBAR as being the
> high bit of the page address due to the limitation of FCM, it simply uses
> the low 6-bits (for large page) of the combined block/page address as the
> FPAR component, rather than considering the actual block size.

Pushed this one to l2-mtd-2.6.git, thanks!

Artem.
