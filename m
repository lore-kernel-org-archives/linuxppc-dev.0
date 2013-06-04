Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5CB2F2C008F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 08:28:29 +1000 (EST)
Date: Tue, 4 Jun 2013 17:28:20 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC PATCH 3/6] KVM: PPC: Book3E: Rename IRQPRIO names to
 accommodate ALTIVEC
To: Mihai Caraman <mihai.caraman@freescale.com>
In-Reply-To: <1370292868-2697-4-git-send-email-mihai.caraman@freescale.com>
 (from mihai.caraman@freescale.com on Mon Jun  3 15:54:25 2013)
Message-ID: <1370384900.748.18@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/03/2013 03:54:25 PM, Mihai Caraman wrote:
> Rename BOOKE_IRQPRIO_SPE_UNAVAIL and BOOKE_IRQPRIO_SPE_FP_DATA names
> to accommodate ALTIVEC. Replace BOOKE_INTERRUPT_SPE_UNAVAIL and
> BOOKE_INTERRUPT_SPE_FP_DATA with the common version.
>=20
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
>  arch/powerpc/kvm/booke.c              |   12 ++++++------
>  arch/powerpc/kvm/booke.h              |    4 ++--
>  arch/powerpc/kvm/bookehv_interrupts.S |    8 ++++----
>  arch/powerpc/kvm/e500.c               |   10 ++++++----
>  arch/powerpc/kvm/e500_emulate.c       |    8 ++++----
>  5 files changed, 22 insertions(+), 20 deletions(-)

Can you remove the TODO separate definitions from 1/6 now?  And/or =20
combine 1/6 with this patch?

-Scott=
