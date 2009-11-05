Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 89E74B7BA4
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 01:04:09 +1100 (EST)
Date: Thu, 5 Nov 2009 17:04:07 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 5/7] powerpc/85xx: Add power management support for
	MPC85xxMDS boards
Message-ID: <20091105140407.GA16698@oksana.dev.rtsoft.ru>
References: <20090915214321.GA19377@oksana.dev.rtsoft.ru>
	<20090915214359.GE24821@oksana.dev.rtsoft.ru>
	<197B3989-3373-4172-B5FA-727CA1EEE2AA@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <197B3989-3373-4172-B5FA-727CA1EEE2AA@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 05, 2009 at 07:58:49AM -0600, Kumar Gala wrote:
[...]
> --- a/arch/powerpc/boot/dts/mpc8568mds.dts
> +++ b/arch/powerpc/boot/dts/mpc8568mds.dts
> @@ -40,6 +40,8 @@
> 			i-cache-line-size = <32>;	// 32 bytes
> 			d-cache-size = <0x8000>;		// L1, 32K
> 			i-cache-size = <0x8000>;		// L1, 32K
> +			sleep = <&pmc 0x00008000	// core
> +				 &pmc 0x00004000>;	// timebase
> 
> Just so I'm clear this is the devdisr bit position?

Yep, as described in the bindings.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
