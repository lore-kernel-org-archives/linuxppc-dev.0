Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 971A01A04DE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 01:08:21 +1100 (AEDT)
Date: Thu, 22 Oct 2015 16:09:02 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, kernel@pengutronix.de
Subject: Re: [PATCH] powerpc: mpc512x: drop bogus and unused psc register
 bit definitions
Message-ID: <20151022160902.0446b1ef@crub>
In-Reply-To: <1437463273-24742-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1437463273-24742-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 21 Jul 2015 09:21:13 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> These were introduced in commit 25ae3a0739c6 ("[POWERPC] mpc512x: Add
> MPC512x PSC support to MPC52xx psc driver") and never used. Moreover
> according to the datasheet[1] MEMERROR is bit 25 (0x40) and ORERR is
> bit 27 (0x10).
>=20
> [1] MPC5125RM Rev. 2; 11/2009
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/powerpc/include/asm/mpc52xx_psc.h | 2 --
>  1 file changed, 2 deletions(-)

applied to mpc5xxx/next.

Thanks,

Anatolij
