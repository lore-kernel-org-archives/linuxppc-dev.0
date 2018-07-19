Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41WNpc6PpGzDqCG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 16:07:36 +1000 (AEST)
In-Reply-To: <20180621083305.5322-1-brgl@bgdev.pl>
To: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: devicetree@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND,
 1/3] powerpc: dts: use 'atmel' as at24 anufacturer for pdm360ng
Message-Id: <41WNpc2DKrz9s4w@ozlabs.org>
Date: Thu, 19 Jul 2018 16:07:36 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-06-21 at 08:33:03 UTC, Bartosz Golaszewski wrote:
> Using 'at' as the <manufacturer> part of the compatible string is now
> deprecated. Use a correct string: 'atmel,<model>'.
> 
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/835b706bab95141e2663b046f2fc59

cheers
