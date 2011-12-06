Return-Path: <dedekind1@gmail.com>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
 [209.85.215.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id B250D1007E6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2011 22:49:33 +1100 (EST)
Received: by lahe6 with SMTP id e6so2237752lah.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Dec 2011 03:49:26 -0800 (PST)
Subject: Re: [PATCH 3/3] mtd/nand : workaround for Freescale FCM to support
 large-page Nand chip
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Date: Tue, 06 Dec 2011 13:49:19 +0200
In-Reply-To: <4EDD1F90.300@freescale.com>
References: <1322973098-2528-1-git-send-email-shuo.liu@freescale.com>
 <1322973098-2528-3-git-send-email-shuo.liu@freescale.com>
 <1323067628.2316.29.camel@koala> <4EDD1F90.300@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1323172165.2163.3.camel@koala>
Mime-Version: 1.0
Cc: Artem.Bityutskiy@nokia.com, dwmw2@infradead.org,
 linux-kernel@vger.kernel.org, shuo.liu@freescale.com,
 linux-mtd@lists.infradead.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-12-05 at 13:46 -0600, Scott Wood wrote:
> Because this is a controller resource, shared by multiple NAND chips
> that may be different page sizes (even if not, it's adding another point
> of synchronization required between initialization of different chips).
>  I don't think it's worth the gymnastics to save a few KiB.

OK, I see.

Artem.
