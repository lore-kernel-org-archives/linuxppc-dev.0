Return-Path: <glikely@secretlab.ca>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 847D4B7091
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  1 Aug 2011 00:26:35 +1000 (EST)
Received: by mail-ww0-f45.google.com with SMTP id 40so3795542wwj.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 31 Jul 2011 07:26:34 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Sat, 30 Jul 2011 22:03:28 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Shaohui Xie <Shaohui.Xie@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: fix memory controller compatible for edac
Message-ID: <20110731040328.GK24334@ponder.secretlab.ca>
References: <1311659193-694-1-git-send-email-Shaohui.Xie@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1311659193-694-1-git-send-email-Shaohui.Xie@freescale.com>
Cc: mm-commits@vger.kernel.org, kumar.gala@freescale.com, avorontsov@mvista.com,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
	davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 26, 2011 at 01:46:33PM +0800, Shaohui Xie wrote:
> compatible in dts has been changed, so driver need to update accordingly.
> 
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> ---
> apply for http://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
> 'next' branch.
> 
>  drivers/edac/mpc85xx_edac.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
> index 13f6cc5..94c064a 100644
> --- a/drivers/edac/mpc85xx_edac.c
> +++ b/drivers/edac/mpc85xx_edac.c
> @@ -1253,7 +1253,7 @@ static struct of_device_id mpc85xx_mc_err_of_match[] = {
>  	{ .compatible = "fsl,p1020-memory-controller", },
>  	{ .compatible = "fsl,p1021-memory-controller", },
>  	{ .compatible = "fsl,p2020-memory-controller", },
> -	{ .compatible = "fsl,p4080-memory-controller", },
> +	{ .compatible = "fsl,qoriq-memory-controller", },

Are there any implementations in the field that depend on the p4080 value?

g.
