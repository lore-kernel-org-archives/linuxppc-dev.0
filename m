Return-Path: <key@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EEBCDB6FA2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2012 06:22:49 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <key@linux.vnet.ibm.com>;
 Wed, 13 Jun 2012 14:22:47 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 9CCD03E4004E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2012 20:22:40 +0000 (WET)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5DKMQMT163686
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2012 14:22:27 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5DKM1GS030273
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2012 14:22:02 -0600
Message-ID: <1339619033.28242.24.camel@key-ThinkPad-W510>
Subject: Re: [PATCH 2/2] drivers: crypto: fix typo in nx driver config option
From: Kent Yoder <key@linux.vnet.ibm.com>
To: Seth Jennings <sjenning@linux.vnet.ibm.com>
Date: Wed, 13 Jun 2012 15:23:53 -0500
In-Reply-To: <1339611763-14603-2-git-send-email-sjenning@linux.vnet.ibm.com>
References: <1339611763-14603-1-git-send-email-sjenning@linux.vnet.ibm.com>
 <1339611763-14603-2-git-send-email-sjenning@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: trivial@kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "David S.
 Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-06-13 at 13:22 -0500, Seth Jennings wrote:
> Cc: Kent Yoder <key@linux.vnet.ibm.com>
> Signed-off-by: Seth Jennings <sjenning@linux.vnet.ibm.com>
> ---
>  drivers/crypto/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Kent Yoder <key@linux.vnet.ibm.com>

> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> index 1092a77..b9b11a6 100644
> --- a/drivers/crypto/Kconfig
> +++ b/drivers/crypto/Kconfig
> @@ -298,7 +298,7 @@ config CRYPTO_DEV_TEGRA_AES
>  	  will be called tegra-aes.
> 
>  config CRYPTO_DEV_NX
> -	tristate "Support for Power7+ in-Nest cryptographic accleration"
> +	tristate "Support for Power7+ in-Nest cryptographic acceleration"
>  	depends on PPC64 && IBMVIO
>  	select CRYPTO_AES
>  	select CRYPTO_CBC
