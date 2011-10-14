Return-Path: <dedekind1@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 23AB6B6F94
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2011 19:37:49 +1100 (EST)
Received: by wwi36 with SMTP id 36so2380136wwi.14
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2011 01:37:44 -0700 (PDT)
Subject: Re: [PATCH] mtd: m25p80: add EON flash EN25Q32B into spi flash id
 table
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Shaohui Xie <Shaohui.Xie@freescale.com>
Date: Fri, 14 Oct 2011 11:37:14 +0300
In-Reply-To: <1317366518-11403-1-git-send-email-Shaohui.Xie@freescale.com>
References: <1317366518-11403-1-git-send-email-Shaohui.Xie@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1318581441.12351.65.camel@sauron>
Mime-Version: 1.0
Cc: linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-09-30 at 15:08 +0800, Shaohui Xie wrote:
> Add support for EON spi flash EN25Q32B, which is not listed in id table,
> need to add it in the id table to support the EON flash.
> 
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Pushed to l2-mtd-2.6.git, thanks!

-- 
Best Regards,
Artem Bityutskiy
