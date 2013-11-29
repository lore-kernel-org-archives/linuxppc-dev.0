Return-Path: <linus.walleij@linaro.org>
Received: from mail-oa0-f52.google.com (mail-oa0-f52.google.com
 [209.85.219.52])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 107702C00C6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Nov 2013 23:37:47 +1100 (EST)
Received: by mail-oa0-f52.google.com with SMTP id h16so10280057oag.39
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Nov 2013 04:37:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1385107960-373-1-git-send-email-Gang.Liu@freescale.com>
References: <1385107960-373-1-git-send-email-Gang.Liu@freescale.com>
Date: Fri, 29 Nov 2013 13:37:41 +0100
Message-ID: <CACRpkday5SGFwhdLgit-am0+Hg0QQmwZonMC8ReQku5UoHp=_A@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/gpio: Fix the wrong GPIO input data on
 MPC8572/MPC8536
From: Linus Walleij <linus.walleij@linaro.org>
To: Liu Gang <Gang.Liu@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 Anatolij Gustschin <agust@denx.de>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 r61911@freescale.com, b07421@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 22, 2013 at 9:12 AM, Liu Gang <Gang.Liu@freescale.com> wrote:

> For MPC8572/MPC8536, the status of GPIOs defined as output
> cannot be determined by reading GPDAT register, so the code
> use shadow data register instead. But the code may give the
> wrong status of GPIOs defined as input under some scenarios:
(...)
> Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
> ---
> changes in v2:
>  - Added more description of the problem.
>  - Reduced one in_be32() call.
>  - Do not modify the shadow data.

Applied this v2 version, added ACKs and tagged for stable.

Yours,
Linus Walleij
