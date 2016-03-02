Return-Path: <joel.stan@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C96EE1A01D7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 12:50:31 +1100 (AEDT)
Received: from mail-ob0-x231.google.com (mail-ob0-x231.google.com
 [IPv6:2607:f8b0:4003:c01::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D68AB1402C0
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Mar 2016 12:50:30 +1100 (AEDT)
Received: by mail-ob0-x231.google.com with SMTP id fz5so53436440obc.0
 for <linuxppc-dev@ozlabs.org>; Tue, 01 Mar 2016 17:50:30 -0800 (PST)
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <1456882616-26811-1-git-send-email-mpe@ellerman.id.au>
References: <1456882616-26811-1-git-send-email-mpe@ellerman.id.au>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 2 Mar 2016 12:20:09 +1030
Message-ID: <CACPK8Xe+vxJe-ArTP7ZU4gKjJtZwviT0t9h7kS1R1WvW6E-msA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add powerpc drivers to the powerpc section
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 2, 2016 at 12:06 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> We'd like folks working on drivers for powerpc to also Cc linuxppc-dev,
> so we can be aware of what's going on in drivers and/or review the
> changes.
>
> So add patterns to the powerpc MAINTAINERS section to catch some of the
> drivers we're interested in.

There are a few more that would be good. '*opal*.c' catches these:

./drivers/i2c/busses/i2c-opal.c
./drivers/rtc/rtc-opal.c
./drivers/tty/hvc/hvc_opal.c

and '*powernv*.c' gets these (some a duplicates with what you have):

./drivers/leds/leds-powernv.c
./drivers/cpufreq/powernv-cpufreq.c
./drivers/mtd/devices/powernv_flash.c
./drivers/cpuidle/cpuidle-powernv.c
./drivers/char/hw_random/powernv-rng.c
./drivers/char/ipmi/ipmi_powernv.c
./drivers/hwmon/ibmpowernv.c
./drivers/crypto/nx/nx-842-powernv.c

Cheers,

Joel
