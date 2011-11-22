Return-Path: <jwboyer@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
 [209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 31C141007D1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2011 22:27:34 +1100 (EST)
Received: by vcbfl15 with SMTP id fl15so81445vcb.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2011 03:27:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1321953786-26472-1-git-send-email-Shengzhou.Liu@freescale.com>
References: <1321953786-26472-1-git-send-email-Shengzhou.Liu@freescale.com>
Date: Tue, 22 Nov 2011 06:27:29 -0500
Message-ID: <CA+5PVA7mbgy_o38DoDBBLWgv0Ew4BYPJ7+36-C2PkHNGz_Tnsw@mail.gmail.com>
Subject: Re: [PATCH] mtd/nand: Add NAND chip ID to support Micron 4k pagesize
 NAND chip
From: Josh Boyer <jwboyer@gmail.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: kumar.gala@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 22, 2011 at 4:23 AM, Shengzhou Liu
<Shengzhou.Liu@freescale.com> wrote:
> Add NAND chip ID 0x38 in ids table to support Micron 4k large-page NAND c=
hip.
>
> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> ---
> =A0drivers/mtd/nand/nand_ids.c | =A0 =A01 +

You really need to send this to the MTD list and have it go through that tr=
ee.

josh
