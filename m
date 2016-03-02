Return-Path: <mikenmeg@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF3471A06BA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 15:19:21 +1100 (AEDT)
Message-ID: <1456892361.24490.10.camel@ellerman.id.au>
Subject: Re: [PATCH] MAINTAINERS: Add powerpc drivers to the powerpc section
From: Mike & Meg <mikenmeg@ellerman.id.au>
To: Joe Perches <joe@perches.com>, Joel Stanley <joel@jms.id.au>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Date: Wed, 02 Mar 2016 15:19:21 +1100
In-Reply-To: <1456889582.4436.43.camel@perches.com>
References: <1456882616-26811-1-git-send-email-mpe@ellerman.id.au>
 <CACPK8Xe+vxJe-ArTP7ZU4gKjJtZwviT0t9h7kS1R1WvW6E-msA@mail.gmail.com>
 <1456888343.24490.8.camel@ellerman.id.au>
 <1456889582.4436.43.camel@perches.com>
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

On Tue, 2016-03-01 at 19:33 -0800, Joe Perches wrote:
> On Wed, 2016-03-02 at 14:12 +1100, Michael Ellerman wrote:
> > On Wed, 2016-03-02 at 12:20 +1030, Joel Stanley wrote:
> > 
> > > 
> > > On Wed, Mar 2, 2016 at 12:06 PM, Michael Ellerman  wrote:
> > > 
> > > > 
> > > > We'd like folks working on drivers for powerpc to also Cc linuxppc-dev,
> > > > so we can be aware of what's going on in drivers and/or review the
> > > > changes.
> > > > 
> > > > So add patterns to the powerpc MAINTAINERS section to catch some of the
> > > > drivers we're interested in.
> > > There are a few more that would be good. '*opal*.c' catches these:
> > > 
> > > ./drivers/i2c/busses/i2c-opal.c
> > > ./drivers/rtc/rtc-opal.c
> > > ./drivers/tty/hvc/hvc_opal.c

> > Ah yep thanks, will add "N: opal".
> 
> N: and F: have different characteristics for get_maintainer.pl
> 
> From MAINTAINERS:
> 
> 	   scripts/get_maintainer.pl has different behavior for files that
> 	   match F: pattern and matches of N: patterns.  By default,
> 	   get_maintainer will not look at git log history when an F: pattern
> 	   match occurs.  When an N: match occurs, git log history is used
> 	   to also notify the people that have git commit signatures.

Yeah I saw that.

What I want is to add linuxppc-dev to whatever it would have done previously.
ie. I don't want to hijack the patches from whoever would have got them.

And listing all the drivers explicitly would be a bit gross:

F:	drivers/block/ps3disk.c
F:	drivers/block/ps3vram.c
F:	drivers/char/hw_random/powernv-rng.c
F:	drivers/char/hw_random/pseries-rng.c
F:	drivers/char/ipmi/ipmi_powernv.c
F:	drivers/char/ps3flash.c
F:	drivers/cpufreq/pmac32-cpufreq.c
F:	drivers/cpufreq/pmac64-cpufreq.c
F:	drivers/cpufreq/powernv-cpufreq.c
F:	drivers/cpuidle/cpuidle-powernv.c
F:	drivers/cpuidle/cpuidle-pseries.c
F:	drivers/crypto/nx/nx-842-powernv.c
F:	drivers/crypto/nx/nx-842-pseries.c
F:	drivers/hwmon/ibmpowernv.c
F:	drivers/i2c/busses/i2c-opal.c
F:	drivers/i2c/busses/i2c-powermac.c
F:	drivers/ide/pmac.c
F:	drivers/leds/leds-powernv.c
F:	drivers/media/rc/keymaps/rc-asus-ps3-100.c
F:	drivers/mtd/devices/powernv_flash.c
F:	drivers/net/ethernet/ti/cpmac.c
F:	drivers/net/ethernet/toshiba/ps3_gelic_net.c
F:	drivers/net/ethernet/toshiba/ps3_gelic_net.h
F:	drivers/net/ethernet/toshiba/ps3_gelic_wireless.c
F:	drivers/net/ethernet/toshiba/ps3_gelic_wireless.h
F:	drivers/ps3/ps3av.c
F:	drivers/ps3/ps3av_cmd.c
F:	drivers/ps3/ps3-lpm.c
F:	drivers/ps3/ps3stor_lib.c
F:	drivers/ps3/ps3-sys-manager.c
F:	drivers/ps3/ps3-vuart.c
F:	drivers/rtc/rtc-opal.c
F:	drivers/rtc/rtc-ps3.c
F:	drivers/scsi/ps3rom.c
F:	drivers/tty/hvc/hvc_opal.c
F:	drivers/tty/serial/pmac_zilog.c
F:	drivers/tty/serial/pmac_zilog.h
F:	drivers/usb/host/ehci-ps3.c
F:	drivers/usb/host/ohci-ps3.c
F:	drivers/video/fbdev/ps3fb.c
F:	sound/ppc/pmac.c
F:	sound/ppc/pmac.h
F:	sound/ppc/powermac.c
F:	sound/ppc/snd_ps3.c
F:	sound/ppc/snd_ps3.h
F:	sound/ppc/snd_ps3_reg.h

cheers
