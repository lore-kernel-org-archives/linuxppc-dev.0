Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xCsvB0wqBzDrFQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 22:01:42 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RESEND PATCH] powerpc: defconfig: Cleanup from old Kconfig
 options
In-Reply-To: <1500526827-3961-1-git-send-email-krzk@kernel.org>
References: <1500526827-3961-1-git-send-email-krzk@kernel.org>
Date: Thu, 20 Jul 2017 22:01:39 +1000
Message-ID: <87k233gvvg.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Krzysztof Kozlowski <krzk@kernel.org> writes:

> Remove old, dead Kconfig option USB_LED. It is gone since
> commit a335aaf3125c ("usb: misc: remove outdated USB LED driver").
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/powerpc/configs/c2k_defconfig    | 1 -
>  arch/powerpc/configs/ppc6xx_defconfig | 1 -
>  2 files changed, 2 deletions(-)

Thanks. I'm working on cleaning up all the dead options in our
defconfigs, so I'll make this part of that series.

cheers
