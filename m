Return-Path: <dgibson@ozlabs.org>
Date: Fri, 19 Oct 2007 10:56:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH v5 9/9] add MPC837x MDS board default device tree
Message-ID: <20071019005613.GA18240@localhost.localdomain>
References: <1192702580-6353-1-git-send-email-leoli@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1192702580-6353-1-git-send-email-leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 18, 2007 at 06:16:20PM +0800, Li Yang wrote:
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/boot/dts/mpc8377_mds.dts
> new file mode 100644
> index 0000000..8530de6
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
> @@ -0,0 +1,282 @@
[snip]
> +		crypto@30000 {
> +			model = "SEC3";
> +			compatible = "talitos";

That compatible doesn't look specific enough.  It should at least have
a vendor portion.  In general it's best to have all the information
you need to pick a driver and options in compatible, rather than
splitting that info into model.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
