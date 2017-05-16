Return-Path: <joel.stan@gmail.com>
Received: from mail-yw0-x244.google.com (mail-yw0-x244.google.com
 [IPv6:2607:f8b0:4002:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRgTl4N9dzDqMc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 11:53:47 +1000 (AEST)
Received: by mail-yw0-x244.google.com with SMTP id 203so7025400ywe.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 18:53:47 -0700 (PDT)
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <20170515130754.59363-1-ivan@de.ibm.com>
References: <20170515130754.59363-1-ivan@de.ibm.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 16 May 2017 11:23:23 +0930
Message-ID: <CACPK8XcQazPbTMxtc5aE=eM+a_aLR5jjfMr55oZcGmifg=0X5w@mail.gmail.com>
Subject: Re: [PATCH 0/4] Support for the FSP2 476fpe board in arch/powerpc
To: Ivan Mikhaylov <ivan@de.ibm.com>
Cc: Alistair Popple <alistair@popple.id.au>,
 Matt Porter <mporter@kernel.crashing.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hey Ivan,

Please use joel@jms.id.au when you cc me on patches. That other
address won't work for most people.

Cheers,

Joel

On Mon, May 15, 2017 at 10:37 PM, Ivan Mikhaylov <ivan@de.ibm.com> wrote:
> This adds support for the FSP2 (476fpe) board. This includes code in
> arch/powerpc/platforms/44x for board initialization. Only uImage is
> supported by now. Also there was some problem with whole watchdog TCR
> rewrite which causing unexpected very early panic and fixed by 4 patch.
> dts and defconfig for common usage included as well. Tested on FSP2 board
> with uboot and initramfs image.
>
> Ivan Mikhaylov (4):
>   arch/powerpc/44x/fsp2: platform support for fsp2(476fpe) board
>   arch/powerpc/44x/fsp2: add device tree for fsp2 board
>   arch/powerpc/44x/fsp2: add defconfig for fsp2 board
>   arch/powerpc/44x/fsp2: wdt tcr update instead of whole rewrite
>
>  arch/powerpc/boot/dts/fsp2.dts          |  608 +++++++++++++++++++++++++++++++
>  arch/powerpc/configs/44x/fsp2_defconfig |  126 +++++++
>  arch/powerpc/kernel/time.c              |   16 +
>  arch/powerpc/platforms/44x/Kconfig      |   12 +
>  arch/powerpc/platforms/44x/Makefile     |    1 +
>  arch/powerpc/platforms/44x/fsp2.c       |   62 ++++
>  6 files changed, 825 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/fsp2.dts
>  create mode 100644 arch/powerpc/configs/44x/fsp2_defconfig
>  create mode 100644 arch/powerpc/platforms/44x/fsp2.c
>
