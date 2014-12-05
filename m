Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E7D2C1A011D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Dec 2014 20:42:48 +1100 (AEDT)
In-Reply-To: <1417767462-11584-1-git-send-email-alessio.bogani@elettra.eu>
To: Alessio Igor Bogani <alessio.bogani@elettra.eu>,
 Scott Wood <scottwood@freescale.com>, Kumar Gala <galak@kernel.crashing.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc: refresh mpc85xx_defconfig using "make savedefconfig"
Message-Id: <20141205094248.D5C9914011E@ozlabs.org>
Date: Fri,  5 Dec 2014 20:42:48 +1100 (AEDT)
Cc: Alessio Igor Bogani <alessio.bogani@elettra.eu>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-05-12 at 08:17:42 UTC, Alessio Igor Bogani wrote:
> Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
> ---
>  arch/powerpc/configs/mpc85xx_defconfig | 57 +++++++---------------------------
>  1 file changed, 12 insertions(+), 45 deletions(-)

Actually I was planning on doing this in bulk for all the powerpc defconfigs.

Someone remind me to do it late next week once most of next has gone into
Linus' tree.

cheers
