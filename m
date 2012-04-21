Return-Path: <dedekind1@gmail.com>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
 [209.85.215.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2AAB7B6F9A
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Apr 2012 03:42:08 +1000 (EST)
Received: by laap9 with SMTP id p9so7535042laa.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Apr 2012 10:42:03 -0700 (PDT)
Message-ID: <1335029970.28267.3.camel@brekeke>
Subject: Re: [PATCH] driver/mtd: IFC NAND: Add support of ONFI NAND flash
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Date: Sat, 21 Apr 2012 20:39:30 +0300
In-Reply-To: <1333949122-10401-1-git-send-email-prabhakar@freescale.com>
References: <1333949122-10401-1-git-send-email-prabhakar@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: scottwood@freescale.com, linux-mtd@lists.infradead.org,
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

On Mon, 2012-04-09 at 10:55 +0530, Prabhakar Kushwaha wrote:
> - Fix NAND_CMD_READID command for ONFI detect.
>   - Add NAND_CMD_PARAM command to read the ONFI parameter page.
> 
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> Acked-by: Scott Wood <scottwood@freescale.com>
> ---
>  Based upon git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git 
>  Branch master

Pushed to l2-mtd.git, thanks!

-- 
Best Regards,
Artem Bityutskiy
