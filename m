Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 04682B7153
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 23:30:06 +1000 (EST)
Message-Id: <7071E2AF-65ED-41C2-AFE7-06E9336619CB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Rini van Zetten <rini@arvoo.nl>
In-Reply-To: <4A30CA1F.4000702@arvoo.nl>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH][POWERPC] mpc83xx : allow SPI without cs.
Date: Thu, 11 Jun 2009 08:29:45 -0500
References: <4A30CA1F.4000702@arvoo.nl>
Cc: spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 11, 2009, at 4:10 AM, Rini van Zetten wrote:

> This patch adds the possibility to have a spi device without a cs.
>
> For example, the dts file should look something like this:
>
> spi-controller {
>       gpios = <&pio1 1 0      /* cs0 */
>                0              /* cs1, no GPIO */
>                &pio2 2 0>;    /* cs2 */
>
>
>
> Signed-off-by: Rini van Zetten <rini@arvoo.nl>
> ---
> drivers/spi/spi_mpc83xx.c |   44 ++++++++++++++++++++++ 
> +---------------------
> 1 files changed, 23 insertions(+), 21 deletions(-)

This patch needs to be respun against the -mm tree as a lot of other  
spi patches are queued up there that will cause this patch to not  
merge correctly.

- k
