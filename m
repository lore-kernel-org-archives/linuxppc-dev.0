Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9B46CDDDFA
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Nov 2008 15:06:01 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	mA645ZtS007826
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Nov 2008 21:05:46 -0700 (MST)
Message-Id: <CF1D1EC1-FA81-48BF-98C9-A30E5C265FF7@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Liu Yu <Yu.Liu@freescale.com>
In-Reply-To: <1225165821-15998-4-git-send-email-yu.liu@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 3/4] math-emu: Remove redundant 'ret'
Date: Wed, 5 Nov 2008 22:05:35 -0600
References: <1225165821-15998-1-git-send-email-yu.liu@freescale.com>
	<1225165821-15998-2-git-send-email-yu.liu@freescale.com>
	<1225165821-15998-3-git-send-email-yu.liu@freescale.com>
	<1225165821-15998-4-git-send-email-yu.liu@freescale.com>
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

> FP_DECL_EX is already used, so ret is redundant.
> And FP_SET_EXCEPTION will add status into return value.
>
> Signed-off-by: Liu Yu <yu.liu@freescale.com>
> ---
> arch/powerpc/math-emu/fadd.c    |    1 -
> arch/powerpc/math-emu/fcmpo.c   |    5 ++---
> arch/powerpc/math-emu/fdiv.c    |    9 ++++-----
> arch/powerpc/math-emu/fdivs.c   |    9 ++++-----
> arch/powerpc/math-emu/fmadd.c   |    5 ++---
> arch/powerpc/math-emu/fmadds.c  |    5 ++---
> arch/powerpc/math-emu/fmsub.c   |    5 ++---
> arch/powerpc/math-emu/fmsubs.c  |    5 ++---
> arch/powerpc/math-emu/fmul.c    |    3 +--
> arch/powerpc/math-emu/fmuls.c   |    3 +--
> arch/powerpc/math-emu/fnmadd.c  |    5 ++---
> arch/powerpc/math-emu/fnmadds.c |    5 ++---
> arch/powerpc/math-emu/fnmsub.c  |    5 ++---
> arch/powerpc/math-emu/fnmsubs.c |    5 ++---
> arch/powerpc/math-emu/fsqrt.c   |    5 ++---
> arch/powerpc/math-emu/fsqrts.c  |    5 ++---
> arch/powerpc/math-emu/fsub.c    |    3 +--
> arch/powerpc/math-emu/fsubs.c   |    3 +--
> 18 files changed, 34 insertions(+), 52 deletions(-)


applied to next.

- k
