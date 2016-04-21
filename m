Return-Path: <robh+dt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrV2b3t6rzDqgp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 05:59:35 +1000 (AEST)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id C75E620351
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 19:59:31 +0000 (UTC)
Received: from mail-yw0-f179.google.com (mail-yw0-f179.google.com
 [209.85.161.179])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7E44C20320
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 19:59:30 +0000 (UTC)
Received: by mail-yw0-f179.google.com with SMTP id o66so101098759ywc.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 12:59:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1461262544-115408-24-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1461262544-115408-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1461262544-115408-24-git-send-email-andriy.shevchenko@linux.intel.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 21 Apr 2016 14:59:10 -0500
Message-ID: <CAL_JsqKGujmO32+Y5ptO_5muQeQ8cbL3S46iky-5mEcR2peAXA@mail.gmail.com>
Subject: Re: [PATCH v1 23/23] powerpc/4xx: Device tree update for the 460ex
 DWC SATA
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tejun Heo <tj@kernel.org>,
 "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christian Lamparter <chunkeey@googlemail.com>,
 =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>,
 Julian Margetson <runaway@candw.ms>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 21, 2016 at 1:15 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Device tree update for the Applied micro processor 460ex on-chip SATA to use
> "dmas" property.
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/powerpc/boot/dts/canyonlands.dts | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)

I see you have maintained compatibility in the driver for old DTs, so:

Acked-by: Rob Herring <robh@kernel.org>
