Return-Path: <manabian@gmail.com>
Received: from mail-wm0-x234.google.com (mail-wm0-x234.google.com
 [IPv6:2a00:1450:400c:c09::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s80XQ3TcrzDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 02:45:58 +1000 (AEST)
Received: by mail-wm0-x234.google.com with SMTP id i5so47769180wmg.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Aug 2016 09:45:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1470742581-12971-1-git-send-email-wsa-dev@sang-engineering.com>
References: <1470742581-12971-1-git-send-email-wsa-dev@sang-engineering.com>
From: Joachim  Eastwood <manabian@gmail.com>
Date: Tue, 9 Aug 2016 18:45:54 +0200
Message-ID: <CAGhQ9VwJk1WZ2cB6Ag3HXfWEwe1GC-G9L2TWem+Lf5moLDx9uQ@mail.gmail.com>
Subject: Re: [PATCH] i2c: don't print error when adding adapter fails
To: Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-i2c@vger.kernel.org,
 adi-buildroot-devel@lists.sourceforge.net, kernel@stlinux.com,
 linux-amlogic@lists.infradead.org,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 linux-omap <linux-omap@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-tegra@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 9 August 2016 at 13:36, Wolfram Sang <wsa-dev@sang-engineering.com> wrote:
> Since v4.8-rc1, the I2C core will print detailed information when adding an I2C
> adapter fails. So, drivers can skip this now.
>
> I am still undecided if I apply this as a single patch or break it out. But for
> reviewing, avoiding the patch bomb is probably a good thing.
>
> Should go via subsystem tree, I'd think.
>
> Wolfram Sang (1):
>   i2c: don't print error when adding adapter fails


For
>  drivers/i2c/busses/i2c-lpc2k.c          | 4 +---

Acked-by: Joachim Eastwood <manabian@gmail.com>


regards,
Joachim Eastwood
