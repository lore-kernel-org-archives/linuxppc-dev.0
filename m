Return-Path: <dedekind1@gmail.com>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
 [209.85.215.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 41EC21007D6
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Dec 2011 17:50:41 +1100 (EST)
Received: by lahe6 with SMTP id e6so1566468lah.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Dec 2011 22:50:33 -0800 (PST)
Subject: Re: [PATCH 1/3] mtd/nand : use elbc_fcm_ctrl->oob to set FPAR_MS
 bit of FPAR
From: Artem Bityutskiy <dedekind1@gmail.com>
To: shuo.liu@freescale.com
Date: Mon, 05 Dec 2011 08:50:29 +0200
In-Reply-To: <1322973098-2528-1-git-send-email-shuo.liu@freescale.com>
References: <1322973098-2528-1-git-send-email-shuo.liu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1323067832.2316.31.camel@koala>
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

On Sun, 2011-12-04 at 12:31 +0800, shuo.liu@freescale.com wrote:
> From: Liu Shuo <b35362@freescale.com>
> 
> On both of large-page chip and small-page chip, we always should use
> 'elbc_fcm_ctrl->oob' to set the FPAR_LP_MS/FPAR_SP_MS bit of FPAR, don't
> use a overflowed 'column' to set it.
> 
> Signed-off-by: Liu Shuo <b35362@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>

Pushed patches 1 and 2 to l2-mtd-2.6.git, thanks!

Artem.
