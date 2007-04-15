Return-Path: <dgibson@ozlabs.org>
Date: Sun, 15 Apr 2007 10:44:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jerry Van Baren <gvb.uboot@gmail.com>
Subject: Re: [PATCH dtc] Add -o <output file> to the usage message.
Message-ID: <20070415004455.GF9104@localhost.localdomain>
References: <20070414221647.GB23870@dellserver.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070414221647.GB23870@dellserver.lan>
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Apr 14, 2007 at 06:16:47PM -0400, Jerry Van Baren wrote:
> 
> Signed-off-by: Gerald Van Baren <vanbaren@cideas.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> 
> Hi Jon,
> 
> It turns out -o <file> was there all along, just not in the usage. :-)

Oops..

> (Jon: sorry for the dup, I messed up the linuxppc-dev@ozlabs.org address
> the first time).
> 
> Best regards,
> gvb
> 
> 
>  dtc.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/dtc.c b/dtc.c
> index a94a402..5767834 100644
> --- a/dtc.c
> +++ b/dtc.c
> @@ -83,6 +83,7 @@ static void usage(void)
>  	fprintf(stderr, "\t\t\tdts - device tree source text\n");
>  	fprintf(stderr, "\t\t\tdtb - device tree blob\n");
>  	fprintf(stderr, "\t\t\tfs - /proc/device-tree style directory\n");
> +	fprintf(stderr, "\t-o <output file>\n");
>  	fprintf(stderr, "\t-O <output format>\n");
>  	fprintf(stderr, "\t\tOutput formats are:\n");
>  	fprintf(stderr, "\t\t\tdts - device tree source text\n");

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
