Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Please pull mpc52xx-next 
In-reply-to: <fa686aa40903061008u707b0988s32f04d757d3feb16@mail.gmail.com> 
References: <fa686aa40903061008u707b0988s32f04d757d3feb16@mail.gmail.com>
Date: Tue, 10 Mar 2009 10:46:19 +1100
Message-ID: <1001.1236642379@neuling.org>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Hey Ben,
> 
> Here are some more for -next.
> 
> The following changes since commit 652e8f8d579d61745094e36b4ff085026a332e73:
>   Benjamin Herrenschmidt (1):
>         Merge commit 'jwb/next' into next
> 
> are available in the git repository at:
> 
>   git://git.secretlab.ca/git/linux-2.6-mpc52xx next

Grant, 

Can you grab this guy too?

http://patchwork.ozlabs.org/patch/24082/

Mikey

> 
> Grant Likely (2):
>       powerpc/5200: Add 'simple-bus' to the of_platform probe list.
>       powerpc/4xx: update ml507 .dts file to release reference design
> 
> Grzegorz Bernacki (2):
>       powerpc/5200: Add digsy-mtc support to mpc5200_defconfig
>       powerpc/5200: On the digsy-mtc, configure PSC4 and PSC5 as UARTs
> 
>  arch/powerpc/boot/dts/digsy_mtc.dts          |   12 ++--
>  arch/powerpc/boot/dts/virtex440-ml507.dts    |  124 +++++++++++++++++++++++-
--
>  arch/powerpc/configs/mpc5200_defconfig       |   71 +++++++++++++--
>  arch/powerpc/platforms/52xx/mpc52xx_common.c |    3 +-
>  4 files changed, 184 insertions(+), 26 deletions(-)
> 
> 
> -- 
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
