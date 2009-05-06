Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id E0F2CDE0EE
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 06:39:40 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so179350yxb.39
	for <linuxppc-dev@ozlabs.org>; Wed, 06 May 2009 13:39:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1241640919-4650-5-git-send-email-wd@denx.de>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<1241640919-4650-5-git-send-email-wd@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 6 May 2009 14:39:19 -0600
Message-ID: <fa686aa40905061339u171559b8va45c210b3e63cf83@mail.gmail.com>
Subject: Re: [PATCH 04/12] mpc5121: Added reset module registers
	representation.
To: Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 6, 2009 at 2:15 PM, Wolfgang Denk <wd@denx.de> wrote:
> From: Piotr Ziecik <kosmo@semihalf.com>
>
> Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
> Signed-off-by: Wolfgang Denk <wd@denx.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: John Rigby <jcrigby@gmail.com>

No patch description.  I would also like to see this patch merged with
the actual user of it since it is so small.

> ---
> =A0arch/powerpc/include/asm/mpc512x.h | =A0 13 +++++++++++++
> =A01 files changed, 13 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/mpc512x.h b/arch/powerpc/include/as=
m/mpc512x.h
> index c48a165..ea50d8d 100644
> --- a/arch/powerpc/include/asm/mpc512x.h
> +++ b/arch/powerpc/include/asm/mpc512x.h
> @@ -16,6 +16,19 @@
> =A0#ifndef __ASM_POWERPC_MPC512x_H__
> =A0#define __ASM_POWERPC_MPC512x_H__
>
> +/* MPC512x Reset module registers */
> +struct mpc512x_reset_module {
> + =A0 =A0 =A0 u32 =A0 =A0 rcwlr; =A0/* Reset Configuration Word Low Regis=
ter */
> + =A0 =A0 =A0 u32 =A0 =A0 rcwhr; =A0/* Reset Configuration Word High Regi=
ster */
> + =A0 =A0 =A0 u32 =A0 =A0 reserved1;
> + =A0 =A0 =A0 u32 =A0 =A0 reserved2;
> + =A0 =A0 =A0 u32 =A0 =A0 rsr; =A0 =A0/* Reset Status Register */
> + =A0 =A0 =A0 u32 =A0 =A0 rmr; =A0 =A0/* Reset Mode Register */
> + =A0 =A0 =A0 u32 =A0 =A0 rpr; =A0 =A0/* Reset Protection Register */
> + =A0 =A0 =A0 u32 =A0 =A0 rcr; =A0 =A0/* Reset Control Register */
> + =A0 =A0 =A0 u32 =A0 =A0 rcer; =A0 /* Reset Control Enable Register */
> +} __attribute__ ((__packed__));

__attribute__((__packed__)); is unnecessary.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
