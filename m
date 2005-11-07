Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 32309686C5
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  7 Nov 2005 18:59:07 +1100 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id jA78766X001385
	for <linuxppc-embedded@ozlabs.org>; Mon, 7 Nov 2005 10:07:06 +0200 (EET)
Message-ID: <436F07F5.1030206@intracom.gr>
Date: Mon, 07 Nov 2005 09:53:25 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: "John W. Linville" <linville@tuxdriver.com>
References: <20051106025701.GA9698@tuxdriver.com>
In-Reply-To: <20051106025701.GA9698@tuxdriver.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-embedded@ozlabs.org
Subject: Re: [patch 2.6.14] fec_8xx: make CONFIG_FEC_8XX depend on CONFIG_8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

John W. Linville wrote:
> Make CONFIG_FEC_8XX depend on CONFIG_8xx.  This keeps allmodconfig from
> breaking on non-8xx (PPC) platforms.
> 
> Signed-off-by: John W. Linville <linville@tuxdriver.com>
> ---
> 
>  drivers/net/fec_8xx/Kconfig |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/fec_8xx/Kconfig b/drivers/net/fec_8xx/Kconfig
> index 4560026..a84c232 100644
> --- a/drivers/net/fec_8xx/Kconfig
> +++ b/drivers/net/fec_8xx/Kconfig
> @@ -1,6 +1,6 @@
>  config FEC_8XX
>  	tristate "Motorola 8xx FEC driver"
> -	depends on NET_ETHERNET
> +	depends on NET_ETHERNET && 8xx
>  	select MII
>  
>  config FEC_8XX_GENERIC_PHY

Yes, this is the correct approach. Please disregard the other
patches floating about.

Regards

Pantelis
