Return-Path: <jkosina@suse.cz>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 03BDDB7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Jan 2011 02:10:58 +1100 (EST)
Date: Mon, 3 Jan 2011 16:10:51 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: [PATCH 1/5]arch:powerpc:platforms:85xx:mpc85xx_mds.c Typo change
	singal to signal
In-Reply-To: <1293754184-1928-1-git-send-email-justinmattock@gmail.com>
Message-ID: <alpine.LNX.2.00.1101031610420.26685@pobox.suse.cz>
References: <1293754184-1928-1-git-send-email-justinmattock@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gregkh@suse.de, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 30 Dec 2010, Justin P. Mattock wrote:

> The patches below fixes a typo "singal" to "signal". Please let me 
> know if anything needs to be changed.
> 
> Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>
> 
> ---
>  arch/powerpc/platforms/85xx/mpc85xx_mds.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> index aa34cac..747d1ee 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> @@ -309,7 +309,7 @@ static void __init mpc85xx_mds_qe_init(void)
>  			/* P1021 has pins muxed for QE and other functions. To
>  			 * enable QE UEC mode, we need to set bit QE0 for UCC1
>  			 * in Eth mode, QE0 and QE3 for UCC5 in Eth mode, QE9
> -			 * and QE12 for QE MII management singals in PMUXCR
> +			 * and QE12 for QE MII management signals in PMUXCR
>  			 * register.
>  			 */

Applied.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
