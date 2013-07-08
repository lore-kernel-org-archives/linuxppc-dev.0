Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 40B7E2C0178
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jul 2013 04:39:47 +1000 (EST)
Subject: Re: [PATCH 1/2] KVM: PPC: Fix kvm_exit_names array
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1372858255-19708-1-git-send-email-mihai.caraman@freescale.com>
Date: Mon, 8 Jul 2013 20:39:40 +0200
Message-Id: <E4CE5690-9C60-4CFF-AA22-519CA2FF1888@suse.de>
References: <1372858255-19708-1-git-send-email-mihai.caraman@freescale.com>
To: Mihai Caraman <mihai.caraman@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 03.07.2013, at 15:30, Mihai Caraman wrote:

> Some exit ids where left out from kvm_exit_names array.
>=20
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
> arch/powerpc/kvm/timing.c |    4 +++-
> 1 files changed, 3 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/timing.c b/arch/powerpc/kvm/timing.c
> index 07b6110..c392d26 100644
> --- a/arch/powerpc/kvm/timing.c
> +++ b/arch/powerpc/kvm/timing.c
> @@ -135,7 +135,9 @@ static const char =
*kvm_exit_names[__NUMBER_OF_KVM_EXIT_TYPES] =3D {
> 	[USR_PR_INST] =3D             "USR_PR_INST",
> 	[FP_UNAVAIL] =3D              "FP_UNAVAIL",
> 	[DEBUG_EXITS] =3D             "DEBUG",
> -	[TIMEINGUEST] =3D             "TIMEINGUEST"
> +	[TIMEINGUEST] =3D             "TIMEINGUEST",
> +	[DBELL_EXITS] =3D             "DBELL",
> +	[GDBELL_EXITS] =3D            "GDBELL"

Please add a comma at the end here, so that we don't have to uselessly =
touch the entry next time again.


Alex
