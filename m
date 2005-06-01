Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id A7AA0679E2
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Jun 2005 04:10:56 +1000 (EST)
Message-ID: <429DFA28.30509@mvista.com>
Date: Wed, 01 Jun 2005 11:10:48 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Jon Loeliger <jdl@freescale.com>
References: <1116607235.29111.20.camel@gleep>	<f003613a0526b7b6a00a0bd477cd5ac3@freescale.com>
	<1117221410.26114.95.camel@cashmere.sps.mot.com>
In-Reply-To: <1117221410.26114.95.camel@cashmere.sps.mot.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Subject: Re: bd_t Cleaning: Board Changes
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jon Loeliger wrote:

> <snip>
>
>Part Two of Four, the Board Changes.
>
> ppc/platforms/4xx/ash.h                 |   21 -
> ppc/platforms/4xx/bubinga.c             |    4 
> ppc/platforms/4xx/bubinga.h             |   23 -
> ppc/platforms/4xx/cpci405.h             |    2 
> ppc/platforms/4xx/ebony.c               |    9 
> ppc/platforms/4xx/ep405.c               |   12 
> ppc/platforms/4xx/ep405.h               |   13 
> ppc/platforms/4xx/luan.c                |    7 
> ppc/platforms/4xx/oak.c                 |   15 
> ppc/platforms/4xx/oak.h                 |   19 -
> ppc/platforms/4xx/oak_setup.h           |    2 
> ppc/platforms/4xx/ocotea.c              |   13 
> ppc/platforms/4xx/redwood5.h            |   13 
> ppc/platforms/4xx/redwood6.c            |   27 -
> ppc/platforms/4xx/redwood6.h            |   13 
> ppc/platforms/4xx/sycamore.h            |   22 -
> ppc/platforms/4xx/walnut.h              |   22 -
> ppc/platforms/4xx/xilinx_ml300.h        |   12 
> ppc/platforms/83xx/mpc834x_sys.c        |   49 +-
> ppc/platforms/83xx/mpc834x_sys.h        |    1 
> ppc/platforms/85xx/mpc8540_ads.c        |   57 ++-
> ppc/platforms/85xx/mpc8560_ads.c        |   21 -
> ppc/platforms/85xx/mpc85xx_ads_common.c |   10 
> ppc/platforms/85xx/mpc85xx_ads_common.h |    1 
> ppc/platforms/85xx/mpc85xx_cds_common.c |   48 +-
> ppc/platforms/85xx/mpc85xx_cds_common.h |    1 
> ppc/platforms/85xx/sbc8560.c            |   19 -
> ppc/platforms/85xx/sbc85xx.c            |   14 
> ppc/platforms/85xx/sbc85xx.h            |    1 
> ppc/platforms/85xx/stx_gp3.c            |   34 -
> ppc/platforms/85xx/stx_gp3.h            |    1 
> ppc/platforms/bseip.h                   |   13 
> ppc/platforms/ccm.h                     |    2 
> ppc/platforms/cpci690.h                 |   10 
> ppc/platforms/est8260.h                 |   18 
> ppc/platforms/fads.h                    |    2 
> ppc/platforms/hdpu.c                    |   13 
> ppc/platforms/hermes.h                  |    2 
> ppc/platforms/ip860.h                   |    2 
> ppc/platforms/ivms8.h                   |    2 
> ppc/platforms/katana.c                  |    6 
> ppc/platforms/lantec.h                  |    2 
> ppc/platforms/lite5200.c                |    9 
> ppc/platforms/lwmon.h                   |    2 
> ppc/platforms/mbx.h                     |   22 -
> ppc/platforms/pcu_e.h                   |    2 
> ppc/platforms/pq2ads.c                  |    1 
> ppc/platforms/pq2ads.h                  |    2 
> ppc/platforms/radstone_ppc7d.c          |   32 -
> ppc/platforms/radstone_ppc7d.h          |    2 
> ppc/platforms/rpx8260.h                 |   19 -
> ppc/platforms/rpxclassic.h              |   13 
> ppc/platforms/rpxlite.h                 |   13 
> ppc/platforms/sandpoint.c               |   11 
> ppc/platforms/sandpoint.h               |    2 
> ppc/platforms/sbc82xx.c                 |    6 
> ppc/platforms/sbc82xx.h                 |    2 
> ppc/platforms/sbs8260.h                 |   18 
> ppc/platforms/spd8xx.h                  |    2 
> ppc/platforms/tqm8260.h                 |    2 
> ppc/platforms/tqm8260_setup.c           |    1 
> ppc/platforms/tqm8xx.h                  |    2 
>
>  
>
<snip>

All,

So is this patch going to go in?  I haven't seen anyone "push it up".  
The reason I'm asking is that I have a couple patches that I would like 
to push up but they will collide with this one so I need to know if it 
(or a variation thereof) is going to go in or not.

Thanks,

Mark
