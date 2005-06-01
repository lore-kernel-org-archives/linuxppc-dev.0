Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id D0B91679E2
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Jun 2005 04:52:56 +1000 (EST)
In-Reply-To: <429DFA28.30509@mvista.com>
References: <429DFA28.30509@mvista.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e0f01bd36d97aff37301a80e506ebc5d@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 1 Jun 2005 13:52:29 -0500
To: "Mark A. Greer" <mgreer@mvista.com>, Dan Malek <dan@embeddededge.com>,
	Matt Porter <mporter@kernel.crashing.org>,
	Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@ozlabs.org
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

Well, as 85xx/83xx maintainer I'm ok with it.  We should probably need 
4xx (Matt) and 8xx/82xx (Dan/Tom) agreement.

- kumar

On Jun 1, 2005, at 1:10 PM, Mark A. Greer wrote:

> Jon Loeliger wrote:
>
>> <snip>
>>
>> Part Two of Four, the Board Changes.
>>
>> ppc/platforms/4xx/ash.h                 |   21 -
>> ppc/platforms/4xx/bubinga.c             |    4
>> ppc/platforms/4xx/bubinga.h             |   23 -
>> ppc/platforms/4xx/cpci405.h             |    2
>> ppc/platforms/4xx/ebony.c               |    9
>> ppc/platforms/4xx/ep405.c               |   12
>> ppc/platforms/4xx/ep405.h               |   13
>> ppc/platforms/4xx/luan.c                |    7
>> ppc/platforms/4xx/oak.c                 |   15
>> ppc/platforms/4xx/oak.h                 |   19 -
>> ppc/platforms/4xx/oak_setup.h           |    2
>> ppc/platforms/4xx/ocotea.c              |   13
>> ppc/platforms/4xx/redwood5.h            |   13
>> ppc/platforms/4xx/redwood6.c            |   27 -
>> ppc/platforms/4xx/redwood6.h            |   13
>> ppc/platforms/4xx/sycamore.h            |   22 -
>> ppc/platforms/4xx/walnut.h              |   22 -
>> ppc/platforms/4xx/xilinx_ml300.h        |   12
>> ppc/platforms/83xx/mpc834x_sys.c        |   49 +-
>> ppc/platforms/83xx/mpc834x_sys.h        |    1
>> ppc/platforms/85xx/mpc8540_ads.c        |   57 ++-
>> ppc/platforms/85xx/mpc8560_ads.c        |   21 -
>> ppc/platforms/85xx/mpc85xx_ads_common.c |   10
>> ppc/platforms/85xx/mpc85xx_ads_common.h |    1
>> ppc/platforms/85xx/mpc85xx_cds_common.c |   48 +-
>> ppc/platforms/85xx/mpc85xx_cds_common.h |    1
>> ppc/platforms/85xx/sbc8560.c            |   19 -
>> ppc/platforms/85xx/sbc85xx.c            |   14
>> ppc/platforms/85xx/sbc85xx.h            |    1
>> ppc/platforms/85xx/stx_gp3.c            |   34 -
>> ppc/platforms/85xx/stx_gp3.h            |    1
>> ppc/platforms/bseip.h                   |   13
>> ppc/platforms/ccm.h                     |    2
>> ppc/platforms/cpci690.h                 |   10
>> ppc/platforms/est8260.h                 |   18
>> ppc/platforms/fads.h                    |    2
>> ppc/platforms/hdpu.c                    |   13
>> ppc/platforms/hermes.h                  |    2
>> ppc/platforms/ip860.h                   |    2
>> ppc/platforms/ivms8.h                   |    2
>> ppc/platforms/katana.c                  |    6
>> ppc/platforms/lantec.h                  |    2
>> ppc/platforms/lite5200.c                |    9
>> ppc/platforms/lwmon.h                   |    2
>> ppc/platforms/mbx.h                     |   22 -
>> ppc/platforms/pcu_e.h                   |    2
>> ppc/platforms/pq2ads.c                  |    1
>> ppc/platforms/pq2ads.h                  |    2
>> ppc/platforms/radstone_ppc7d.c          |   32 -
>> ppc/platforms/radstone_ppc7d.h          |    2
>> ppc/platforms/rpx8260.h                 |   19 -
>> ppc/platforms/rpxclassic.h              |   13
>> ppc/platforms/rpxlite.h                 |   13
>> ppc/platforms/sandpoint.c               |   11
>> ppc/platforms/sandpoint.h               |    2
>> ppc/platforms/sbc82xx.c                 |    6
>> ppc/platforms/sbc82xx.h                 |    2
>> ppc/platforms/sbs8260.h                 |   18
>> ppc/platforms/spd8xx.h                  |    2
>> ppc/platforms/tqm8260.h                 |    2
>> ppc/platforms/tqm8260_setup.c           |    1
>> ppc/platforms/tqm8xx.h                  |    2
>>
>>
>>
> <snip>
>
> All,
>
> So is this patch going to go in?  I haven't seen anyone "push it up".
> The reason I'm asking is that I have a couple patches that I would like
> to push up but they will collide with this one so I need to know if it
> (or a variation thereof) is going to go in or not.
>
> Thanks,
>
> Mark
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
