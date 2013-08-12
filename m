Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 630252C00FF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Aug 2013 08:17:03 +1000 (EST)
Date: Tue, 13 Aug 2013 00:16:54 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] powerpc: 52xx: provide a default in mpc52xx_irqhost_map()
Message-ID: <20130813001654.16d67af6@crub>
In-Reply-To: <1376317073-14302-1-git-send-email-bigeasy@linutronix.de>
References: <1376317073-14302-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, Wolfram Sang <w.sang@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 12 Aug 2013 16:17:53 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> My gcc-4.3.5 fails to compile due to:
>=20
> |cc1: warnings being treated as errors
> |arch/powerpc/platforms/52xx/mpc52xx_pic.c: In function =E2=80=98mpc52xx_=
irqhost_map=E2=80=99:
> |arch/powerpc/platforms/52xx/mpc52xx_pic.c:343: error: =E2=80=98irqchip=
=E2=80=99 may be used uninitialized in this function
>=20
> since commit e34298c ("powerpc: 52xx: nop out unsupported critical
> IRQs"). This warning is complete crap since only values 0=E2=80=A63 are p=
ossible
> which are checked but gcc fails to understand that. I wouldn't care much
> but since this is compiled with -Werror I made this patch.
> While add it, I replaced the warning from l2irq to l1irq since this is
> the number that is evaluated.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/powerpc/platforms/52xx/mpc52xx_pic.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks!

Anatolij
