Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4E4C1DDFC6
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 10:40:39 +1100 (EST)
Subject: Re: [PATCH] Documentation: fix mdio-gpio name in
	booting-without-of.txt
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
In-Reply-To: <20081117143238.8214.68389.stgit@Programuotojas.82-135-208-232.ip.zebra.lt>
References: <20081117143238.8214.68389.stgit@Programuotojas.82-135-208-232.ip.zebra.lt>
Content-Type: text/plain
Date: Wed, 07 Jan 2009 10:40:32 +1100
Message-Id: <1231285232.14860.33.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-11-17 at 16:32 +0200, Paulius Zaleckas wrote:
> Signed-off-by: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
> ---
> 
>  Documentation/powerpc/booting-without-of.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> 
> diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
> index 0ab0230..8670acc 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -1822,7 +1822,7 @@ platforms are moved over to use the flattened-device-tree model.
>     g) MDIO on GPIOs
>  
>     Currently defined compatibles:
> -   - virtual,gpio-mdio
> +   - virtual,mdio-gpio

Except that the only occurence in the code seems to have it the 
other way round ...
