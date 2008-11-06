Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 081B2DDDF0
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Nov 2008 15:03:51 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	mA643Hek005713
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Nov 2008 21:03:48 -0700 (MST)
Message-Id: <77081526-C863-4B33-91E7-0694DB3132B1@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Liu Yu <Yu.Liu@freescale.com>
In-Reply-To: <1225165821-15998-2-git-send-email-yu.liu@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 1/4] math-emu: Fix single float point division bug
Date: Wed, 5 Nov 2008 22:03:17 -0600
References: <1225165821-15998-1-git-send-email-yu.liu@freescale.com>
	<1225165821-15998-2-git-send-email-yu.liu@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 27, 2008, at 10:50 PM, Liu Yu wrote:

> PowerPC float point division emulation is derived from gcc.
> I reported this problem on gcc maillist and got this reply:
> http://gcc.gnu.org/ml/gcc/2008-03/msg00543.html
>
> Since UDIV_NEEDS_NORMALIZATION is not used by kernel, we should use
> _FP_DIV_MEAT_1_udiv_norm to make sure the single float point
> is normalized before udiv_qrnnd.
>
> Signed-off-by: Liu Yu <yu.liu@freescale.com>
> ---
> arch/powerpc/include/asm/sfp-machine.h |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

applied to next.

- k
