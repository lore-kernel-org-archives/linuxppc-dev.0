Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1C781B7014
 for <linuxppc-dev@ozlabs.org>; Fri, 20 Apr 2012 06:15:31 +1000 (EST)
Subject: Re: [PATCH 1/4] powerpc/mpic_msgr: fix compile error when SMP disabled
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1334541908-19331-1-git-send-email-Mingkai.hu@freescale.com>
Date: Thu, 19 Apr 2012 15:15:32 -0500
Message-Id: <F0561787-724C-42BB-8B18-34F62F635DBF@kernel.crashing.org>
References: <1334541908-19331-1-git-send-email-Mingkai.hu@freescale.com>
To: Mingkai Hu <Mingkai.hu@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 15, 2012, at 9:05 PM, Mingkai Hu wrote:

> In file included from arch/powerpc/sysdev/mpic_msgr.c:20:0:
> ~/arch/powerpc/include/asm/mpic_msgr.h: In function =
'mpic_msgr_set_destination':
> ~/arch/powerpc/include/asm/mpic_msgr.h:117:2:
> error: implicit declaration of function 'get_hard_smp_processor_id'
> make[1]: *** [arch/powerpc/sysdev/mpic_msgr.o] Error 1
>=20
> Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
> ---
> arch/powerpc/include/asm/mpic_msgr.h |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)

applied to merge

- k=
