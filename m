Return-Path: <pku.leo@gmail.com>
Received: from mail-lb0-f169.google.com (mail-lb0-f169.google.com
 [209.85.217.169])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B2FFD14011D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 May 2014 18:31:52 +1000 (EST)
Received: by mail-lb0-f169.google.com with SMTP id s7so5285866lbd.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 May 2014 01:31:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1399514666-2572-1-git-send-email-Yuantian.Tang@freescale.com>
References: <1399514666-2572-1-git-send-email-Yuantian.Tang@freescale.com>
Date: Fri, 9 May 2014 16:31:47 +0800
Message-ID: <CADRPPNSPwiveWEH++ZqDXH5u=mQxAiuh+Ci=1hBH1g6qz4-2dw@mail.gmail.com>
Subject: Re: [PATCH 1/1] booke/watchdog: refine and clean up the codes
From: Leo Li <pku.leo@gmail.com>
To: Yuantian.Tang@freescale.com
Content-Type: text/plain; charset=UTF-8
Cc: Scott Wood <scottwood@freescale.com>, wim@iguana.be,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-watchdog@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 8, 2014 at 10:04 AM,  <Yuantian.Tang@freescale.com> wrote:
> From: Tang Yuantian <yuantian.tang@freescale.com>
>
> Basically, this patch does the following:
> 1. Move the codes of parsing boot parameters from setup-common.c
>    to driver. In this way, code reader can know directly that
>    there are boot parameters that can change the timeout.
> 2. Make boot parameter 'booke_wdt_period' effective.
>    currently, when driver is loaded, default timeout is always
>    being used in stead of booke_wdt_period.
> 3. Wrap up the watchdog timeout in device struct and clean up
>    unnecessary codes.
>
> Signed-off-by: Tang Yuantian <yuantian.tang@freescale.com>
> Acked-by: Scott Wood <scottwood@freescale.com>

Reviewed-by: Li Yang <leoli@freescale.com>
