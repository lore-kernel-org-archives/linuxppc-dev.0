Return-Path: <dedekind1@gmail.com>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
 [209.85.215.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 3AC101007D3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2011 08:19:49 +1100 (EST)
Received: by lago2 with SMTP id o2so419885lag.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Dec 2011 13:19:45 -0800 (PST)
Subject: Re: [PATCH 3/3] mtd/nand : workaround for Freescale FCM to support
 large-page Nand chip
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Date: Mon, 12 Dec 2011 23:19:37 +0200
In-Reply-To: <4EE66EFE.1050608@freescale.com>
References: <1322973098-2528-1-git-send-email-shuo.liu@freescale.com>
 <1322973098-2528-3-git-send-email-shuo.liu@freescale.com>
 <4EDEAEB9.6020703@freescale.com> <1323724195.2297.11.camel@koala>
 <4EE66EFE.1050608@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1323724784.2297.20.camel@koala>
Mime-Version: 1.0
Cc: Artem.Bityutskiy@nokia.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, shuo.liu@freescale.com,
 linux-mtd@lists.infradead.org, akpm@linux-foundation.org, dwmw2@infradead.org
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-12-12 at 15:15 -0600, Scott Wood wrote:
> NAND chips come from the factory with bad blocks marked at a certain
> offset into each page.  This offset is normally in the OOB area, but
> since we change the layout from "4k data, 128 byte oob" to "2k data, 64
> byte oob, 2k data, 64 byte oob" the marker is no longer in the oob.  On
> first use we need to migrate the markers so that they are still in the oob.

Ah, I see, thanks. Are you planning to implement in-kernel migration or
use a user-space tool?

Artem.
