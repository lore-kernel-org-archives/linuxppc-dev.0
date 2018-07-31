Return-Path: <robherring2@gmail.com>
Received: from mail-it0-f66.google.com (mail-it0-f66.google.com
 [209.85.214.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41g97m25MpzF162
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 07:49:23 +1000 (AEST)
Received: by mail-it0-f66.google.com with SMTP id d70-v6so13608090ith.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 14:49:23 -0700 (PDT)
Date: Tue, 31 Jul 2018 15:49:20 -0600
From: Rob Herring <robh@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Joe Perches <joe@perches.com>, Samuel Ortiz <sameo@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Jonathan Cameron <jic23@kernel.org>, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
 lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org
Subject: Re: [PATCH 1/4] treewide: convert ISO_8859-1 text comments to utf-8
Message-ID: <20180731214920.GA20796@rob-hp-laptop>
References: <20180724111600.4158975-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180724111600.4158975-1-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 24, 2018 at 01:13:25PM +0200, Arnd Bergmann wrote:
> Almost all files in the kernel are either plain text or UTF-8
> encoded. A couple however are ISO_8859-1, usually just a few
> characters in a C comments, for historic reasons.
> 
> This converts them all to UTF-8 for consistency.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  .../devicetree/bindings/net/nfc/pn544.txt     |   2 +-
>  arch/arm/boot/dts/sun4i-a10-inet97fv2.dts     |   2 +-
>  arch/arm/crypto/sha256_glue.c                 |   2 +-
>  arch/arm/crypto/sha256_neon_glue.c            |   4 +-
>  drivers/crypto/vmx/ghashp8-ppc.pl             |  12 +-
>  drivers/iio/dac/ltc2632.c                     |   2 +-
>  drivers/power/reset/ltc2952-poweroff.c        |   4 +-
>  kernel/events/callchain.c                     |   2 +-
>  net/netfilter/ipvs/Kconfig                    |   8 +-
>  net/netfilter/ipvs/ip_vs_mh.c                 |   4 +-
>  tools/power/cpupower/po/de.po                 |  44 +++----
>  tools/power/cpupower/po/fr.po                 | 120 +++++++++---------
>  12 files changed, 103 insertions(+), 103 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/nfc/pn544.txt b/Documentation/devicetree/bindings/net/nfc/pn544.txt
> index 538a86f7b2b0..72593f056b75 100644
> --- a/Documentation/devicetree/bindings/net/nfc/pn544.txt
> +++ b/Documentation/devicetree/bindings/net/nfc/pn544.txt
> @@ -2,7 +2,7 @@
>  
>  Required properties:
>  - compatible: Should be "nxp,pn544-i2c".
> -- clock-frequency: I²C work frequency.
> +- clock-frequency: IÂ²C work frequency.

I'd prefer just plain ASCII 'I2C' here, but either way:

Acked-by: Rob Herring <robh@kernel.org>

Rob
