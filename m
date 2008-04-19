Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id A0285DE00B
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 19:13:09 +1000 (EST)
Date: Sat, 19 Apr 2008 02:12:56 -0700 (PDT)
Message-Id: <20080419.021256.26059313.davem@davemloft.net>
To: khali@linux-fr.org
Subject: Re: [PATCH] [POWERPC] i2c: fix build breakage introduced by OF helpers
From: David Miller <davem@davemloft.net>
In-Reply-To: <20080419110934.672648e6@hyperion.delvare>
References: <18441.33181.511355.338428@cargo.ozlabs.ibm.com>
	<20080418.231128.97404791.davem@davemloft.net>
	<20080419110934.672648e6@hyperion.delvare>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, i2c@lm-sensors.org, scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 19 Apr 2008 11:09:34 +0200

> Guys, you're doing things the wrong way around. Breaking things to fix
> them later is not OK, it's a pain for testers and also when bisecting
> the kernel. Everything should still work after merging the powerpc
> tree. Dave, if you need to loosen the dependency, you should do it
> yourself _after_ having changed whatever needs to be in the sparc32 and
> sparc64 trees so that loosening the dependency doesn't break anything.
> As far as I can see it's only a matter of changing one line in a
> Kconfig file, that's not exactly difficult to do it in the right order.

Fair enough.

At least don't move this stuff under arch/powerpc as paulus originally
had suggested.
