Return-Path: <neko@genesi-usa.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 06F874F382
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2009 05:00:06 +1100 (EST)
MIME-Version: 1.0
In-Reply-To: <20090121205506.31232.27908.stgit@localhost.localdomain>
References: <20090121205506.31232.27908.stgit@localhost.localdomain>
Date: Tue, 27 Jan 2009 12:00:00 -0600
Message-ID: <b5e2fc790901271000r1b7b6313ta63a6e59e2a176e9@mail.gmail.com>
Subject: Re: [PATCH 1/8] powerpc/5200: update device tree binding
	documentation
From: Matt Sealey <matt@genesi-usa.com>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, devtree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 21, 2009 at 2:55 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>
> This patch updates the mpc5200 binding documentation to match
> actual usage conventions, to remove incorrect information, and
> to remove topics which are more thoroughly described elsewhere.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> CC: devtree-discuss@ozlabs.org
> CC: Wolfram Sang <w.sang@pengutronix.de>
> ---
> +It is *strongly* recommended that 5200B device trees follow this convention
> +(instead of only listing the base mpc5200 item).
> +
> +ie. ethernet on mpc5200: compatible = "fsl,mpc5200-ethernet";
> +    ethernet on mpc5200b: compatible = "fsl,mpc5200b-ethernet",
> +                                       "fsl,mpc5200-ethernet";

snip

> +ethernet@<addr>        fsl,mpc5200-fec          MPC5200 ethernet device

snip

> +fsl,mpc5200-fec nodes
> +---------------------
> +The FEC node can specify one of the following properties to configure
> +the MII link:


Is it fec or ethernet? Obviously the first one is an example only but
it should least reflect real life..

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
