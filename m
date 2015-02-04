Return-Path: <linus.walleij@linaro.org>
Received: from mail-ob0-f169.google.com (mail-ob0-f169.google.com
 [209.85.214.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5298E1A09E1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Feb 2015 21:07:15 +1100 (AEDT)
Received: by mail-ob0-f169.google.com with SMTP id wp4so583762obc.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Feb 2015 02:07:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1422712065-9403-11-git-send-email-haokexin@gmail.com>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
 <1422712065-9403-11-git-send-email-haokexin@gmail.com>
Date: Wed, 4 Feb 2015 11:07:12 +0100
Message-ID: <CACRpkdZWTmacX_H+ji3K4zm0z3WwyKJrBsbEMcnkbT1DntjS6Q@mail.gmail.com>
Subject: Re: [PATCH 10/15] gpio: kconfig: replace PPC_OF with PPC
From: Linus Walleij <linus.walleij@linaro.org>
To: Kevin Hao <haokexin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 Alexandre Courbot <gnurou@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jan 31, 2015 at 2:47 PM, Kevin Hao <haokexin@gmail.com> wrote:

> The PPC_OF is a ppc specific option which is used to mean that the
> firmware device tree access functions are available. Since all the
> ppc platforms have a device tree, it is aways set to 'y' for ppc.
> So it makes no sense to keep a such option in the current kernel.
> Replace it with PPC.
>
> Signed-off-by: Kevin Hao <haokexin@gmail.com>

Patch applied.

Yours,
Linus Walleij
