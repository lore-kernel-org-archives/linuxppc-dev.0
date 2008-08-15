Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 7E043DE0E1
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Aug 2008 17:27:51 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH 1/2] port ndfc driver to of platform
Date: Fri, 15 Aug 2008 09:27:41 +0200
References: <20080801233000.3574434f@lappy.seanm.ca>
	<20080814165422.62339a5f@lappy.seanm.ca>
	<20080814191041.60ffed5c@lappy.seanm.ca>
In-Reply-To: <20080814191041.60ffed5c@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808150927.41993.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 15 August 2008, Sean MacLennan wrote:
> Port the ndfc driver to an OF platform driver.
> 
> Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Looks great, but I just noticed one more detail:

> +static const struct of_device_id ndfc_match[] = {
> +	{ .compatible = "amcc,ndfc", },
> +	{}
>  };
>  

You should add

MODULE_DEVICE_TABLE(of, &ndfc_match);

to enable module auto-loading.

	Arnd <><
