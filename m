Return-Path: <anton@scarybugs.org>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
 [209.85.220.48])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BFDC02C0091
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 11:45:42 +1000 (EST)
Received: by mail-pa0-f48.google.com with SMTP id kp13so41595pab.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 18:45:40 -0700 (PDT)
Sender: Anton Vorontsov <anton@scarybugs.org>
Date: Thu, 22 Aug 2013 18:45:38 -0700
From: Anton Vorontsov <anton@enomsg.org>
To: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: Re: [PATCH V3] mmc:of_spi: Update the code of getting voltage-ranges
Message-ID: <20130823014538.GB24803@teo>
References: <1376271546-25085-1-git-send-email-Haijun.Zhang@freescale.com>
 <1376271546-25085-3-git-send-email-Haijun.Zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1376271546-25085-3-git-send-email-Haijun.Zhang@freescale.com>
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

On Mon, Aug 12, 2013 at 09:39:05AM +0800, Haijun Zhang wrote:
> Using function mmc_of_parse_voltage() to get voltage-ranges.
> 
> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> ---

Acked-by: Anton Vorontsov <anton@enomsg.org>
