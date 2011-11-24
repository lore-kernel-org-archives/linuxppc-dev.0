Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 051451007E5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 16:04:34 +1100 (EST)
Subject: Re: [PATCH] powerpc/85xx: Add lbc suspend support for PM
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1321856951-10789-1-git-send-email-B38951@freescale.com>
Date: Wed, 23 Nov 2011 23:04:22 -0600
Message-Id: <90248499-09DC-4C85-A01A-730281CBC949@kernel.crashing.org>
References: <1321856951-10789-1-git-send-email-B38951@freescale.com>
To: Jia Hongtao <B38951@freescale.com>
Cc: B11780@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 21, 2011, at 12:29 AM, Jia Hongtao wrote:

> Power supply for LBC registers is off when system go to deep-sleep =
state.
> We save the values of registers before suspend and restore to =
registers
> after resume.
>=20
> We removed the last two reservation arrays from struct fsl_lbc_regs =
for
> allocating less memory and minimizing the memcpy size.
>=20
> Signed-off-by: Jiang Yutang <b14898@freescale.com>
> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/include/asm/fsl_lbc.h |    7 +++++--
> arch/powerpc/sysdev/fsl_lbc.c      |   36 =
++++++++++++++++++++++++++++++++++++
> 2 files changed, 41 insertions(+), 2 deletions(-)

applied to next

- k=
