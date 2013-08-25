Return-Path: <cjb@laptop.org>
Received: from void.printf.net (void.printf.net [89.145.121.20])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 65C212C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Aug 2013 14:46:56 +1000 (EST)
From: Chris Ball <cjb@laptop.org>
To: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: Re: [PATCH V3] mmc:of_spi: Update the code of getting voltage-ranges
References: <1376271546-25085-1-git-send-email-Haijun.Zhang@freescale.com>
 <1376271546-25085-3-git-send-email-Haijun.Zhang@freescale.com>
Date: Sun, 25 Aug 2013 00:19:19 -0400
In-Reply-To: <1376271546-25085-3-git-send-email-Haijun.Zhang@freescale.com>
 (Haijun Zhang's message of "Mon, 12 Aug 2013 09:39:05 +0800")
Message-ID: <87txiepflk.fsf@octavius.laptop.org>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-mmc@vger.kernel.org, cbouatmailru@gmail.com, scottwood@freescale.com,
 linuxppc-dev@lists.ozlabs.org, X.Xie@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Haijun,

On Sun, Aug 11 2013, Haijun Zhang wrote:
> Using function mmc_of_parse_voltage() to get voltage-ranges.
>
> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>

The patchset contains patches 1-3 of 3, and also this unnumbered patch
v3.  Which order should I use to apply this patch?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
