Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8871D1A03DF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 14:12:23 +1100 (AEDT)
Message-ID: <1456888343.24490.8.camel@ellerman.id.au>
Subject: Re: [PATCH] MAINTAINERS: Add powerpc drivers to the powerpc section
From: Michael Ellerman <mpe@ellerman.id.au>
To: Joel Stanley <joel@jms.id.au>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Date: Wed, 02 Mar 2016 14:12:23 +1100
In-Reply-To: <CACPK8Xe+vxJe-ArTP7ZU4gKjJtZwviT0t9h7kS1R1WvW6E-msA@mail.gmail.com>
References: <1456882616-26811-1-git-send-email-mpe@ellerman.id.au>
 <CACPK8Xe+vxJe-ArTP7ZU4gKjJtZwviT0t9h7kS1R1WvW6E-msA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-03-02 at 12:20 +1030, Joel Stanley wrote:

> On Wed, Mar 2, 2016 at 12:06 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:

> > We'd like folks working on drivers for powerpc to also Cc linuxppc-dev,
> > so we can be aware of what's going on in drivers and/or review the
> > changes.
> > 
> > So add patterns to the powerpc MAINTAINERS section to catch some of the
> > drivers we're interested in.
> 
> There are a few more that would be good. '*opal*.c' catches these:
> 
> ./drivers/i2c/busses/i2c-opal.c
> ./drivers/rtc/rtc-opal.c
> ./drivers/tty/hvc/hvc_opal.c

Ah yep thanks, will add "N: opal".

> and '*powernv*.c' gets these (some a duplicates with what you have):
> 
> ./drivers/leds/leds-powernv.c
> ./drivers/cpufreq/powernv-cpufreq.c
> ./drivers/mtd/devices/powernv_flash.c
> ./drivers/cpuidle/cpuidle-powernv.c
> ./drivers/char/hw_random/powernv-rng.c
> ./drivers/char/ipmi/ipmi_powernv.c
> ./drivers/hwmon/ibmpowernv.c
> ./drivers/crypto/nx/nx-842-powernv.c

They should all be covered by "N: powernv" I think:

    $ for f in ./drivers/leds/leds-powernv.c ./drivers/cpufreq/powernv-cpufreq.c ./drivers/mtd/devices/powernv_flash.c ./drivers/cpuidle/cpuidle-powernv.c ./drivers/char/hw_random/powernv-rng.c
./drivers/char/ipmi/ipmi_powernv.c ./drivers/hwmon/ibmpowernv.c ./drivers/crypto/nx/nx-842-powernv.c; do echo -en "$f\t"; ./scripts/get_maintainer.pl -f $f | grep linuxppc-dev; done
    ./drivers/leds/leds-powernv.c		linuxppc-dev@lists.ozlabs.org
    ./drivers/cpufreq/powernv-cpufreq.c		linuxppc-dev@lists.ozlabs.org
    ./drivers/mtd/devices/powernv_flash.c	linuxppc-dev@lists.ozlabs.org
    ./drivers/cpuidle/cpuidle-powernv.c		linuxppc-dev@lists.ozlabs.org
    ./drivers/char/hw_random/powernv-rng.c	linuxppc-dev@lists.ozlabs.org
    ./drivers/char/ipmi/ipmi_powernv.c		linuxppc-dev@lists.ozlabs.org
    ./drivers/hwmon/ibmpowernv.c		linuxppc-dev@lists.ozlabs.org
    ./drivers/crypto/nx/nx-842-powernv.c	linuxppc-dev@lists.ozlabs.org


cheers
