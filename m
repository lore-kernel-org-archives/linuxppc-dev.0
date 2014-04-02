Return-Path: <gnurou@gmail.com>
Received: from mail-ig0-x235.google.com (mail-ig0-x235.google.com
 [IPv6:2607:f8b0:4001:c05::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BEDA5140101
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Apr 2014 20:42:19 +1100 (EST)
Received: by mail-ig0-f181.google.com with SMTP id h18so60238igc.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Apr 2014 02:42:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1396156455-4225-1-git-send-email-shc_work@mail.ru>
References: <1396156455-4225-1-git-send-email-shc_work@mail.ru>
From: Alexandre Courbot <gnurou@gmail.com>
Date: Wed, 2 Apr 2014 18:41:55 +0900
Message-ID: <CAAVeFu+8sjgtGGUv8O+FLy_3vbtQV+2m5rsJ9FccPoq6AiOFsg@mail.gmail.com>
Subject: Re: [PATCH] gpio: ge: Convert to platform driver
To: Alexander Shiyan <shc_work@mail.ru>
Content-Type: text/plain; charset=UTF-8
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Mar 30, 2014 at 2:14 PM, Alexander Shiyan <shc_work@mail.ru> wrote:
> This patch converts GE I/O FPGA GPIO driver to platform driver.
>
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
> Only compile tested.

Could we get a couple of Tested-by by people who can try this patch?
It greatly simplifies the driver, but we need to make sure it doesn't
break anything before going further...
