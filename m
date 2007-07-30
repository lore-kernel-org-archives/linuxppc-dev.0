Return-Path: <shemminger@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E864DDDEBE
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 02:30:40 +1000 (EST)
Date: Mon, 30 Jul 2007 17:25:35 +0100
From: Stephen Hemminger <shemminger@linux-foundation.org>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: Re: [PATCH 2/4][RFC] lro: Kconfig and Makefile
Message-ID: <20070730172535.15993806@oldman.hamilton.local>
In-Reply-To: <200707301724.45781.ossthema@de.ibm.com>
References: <200707301724.45781.ossthema@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Thomas Klein <tklein@de.ibm.com>, Jeff Garzik <jeff@garzik.org>,
	Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>, Stefan,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>, Andrew Gallatin <gallatin@myri.com>,
	Roscher <stefan.roscher@de.ibm.com>, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 30 Jul 2007 17:24:45 +0200
Jan-Bernd Themann <ossthema@de.ibm.com> wrote:

> Kconfig and Makefile for LRO
> 
> Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
> 
> ---
>  net/ipv4/Kconfig  |    8 ++++++++
>  net/ipv4/Makefile |    1 +
>  2 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
> index fb79097..d894f61 100644
> --- a/net/ipv4/Kconfig
> +++ b/net/ipv4/Kconfig
> @@ -394,6 +394,14 @@ config INET_XFRM_MODE_BEET
>  
>  	  If unsure, say Y.
>  
> +config INET_LRO
> +	tristate "Large Receive Offload (ipv4/tcp)"
> +
> +	---help---
> +	  Support for Large Receive Offload (ipv4/tcp).
> +
> +	  If unsure, say Y.
> +

Why make this a user selectable option at all? Unless you want
to deal with out of tree drivers (not my problem), it should be hidden
to avoid having to explain an support it.
