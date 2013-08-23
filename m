Return-Path: <anton@scarybugs.org>
Received: from mail-pd0-f172.google.com (mail-pd0-f172.google.com
 [209.85.192.172])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8F10A2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 11:48:45 +1000 (EST)
Received: by mail-pd0-f172.google.com with SMTP id z10so42139pdj.31
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 18:48:43 -0700 (PDT)
Sender: Anton Vorontsov <anton@scarybugs.org>
Date: Thu, 22 Aug 2013 18:48:41 -0700
From: Anton Vorontsov <anton@enomsg.org>
To: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: Re: [PATCH 2/3 V3] mmc:sdhc: get voltage from sdhc host
Message-ID: <20130823014841.GD24803@teo>
References: <1376271546-25085-1-git-send-email-Haijun.Zhang@freescale.com>
 <1376271546-25085-4-git-send-email-Haijun.Zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1376271546-25085-4-git-send-email-Haijun.Zhang@freescale.com>
Cc: linux-mmc@vger.kernel.org, scottwood@freescale.com, cjb@laptop.org,
 linuxppc-dev@lists.ozlabs.org, X.Xie@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 12, 2013 at 09:39:06AM +0800, Haijun Zhang wrote:
> We use host->ocr_mask to hold the voltage get from device-tree
> node, In case host->ocr_mask was available, we use host->ocr_mask
> as the final available voltage can be used by MMC/SD/SDIO card.
> 
> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> ---

Reviewed-by: Anton Vorontsov <anton@enomsg.org>
