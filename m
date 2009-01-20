Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 943E0DDDFA
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 00:57:17 +1100 (EST)
Message-ID: <4975D838.5080703@denx.de>
Date: Tue, 20 Jan 2009 14:57:12 +0100
From: Anatolij Gustschin <agust@denx.de>
MIME-Version: 1.0
To: Julian Calaby <julian.calaby@gmail.com>
Subject: Re: [PATCH] mb862xx: Restrict compliation of platform driver to PPC
References: <496A89A1.8050302@gmail.com>
In-Reply-To: <496A89A1.8050302@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>,
	Matteo Fortini <m.fortini@selcomgroup.com>, linux-kernel@vger.kernel.org,
	Krzysztof Helt <krzysztof.h1@poczta.fm>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Julian Calaby wrote:
> mb862xx: Restrict compliation of platform driver to PPC
> 
> The OpenFirmware part of this driver is uncompilable on SPARC due to it's dependance on several PPC specific functions.
> 
> Restricting this to PPC to prevent these build errors.
> 
> This was found using randconfig builds.
> 
> Signed-off-by: Julian Calaby <julian.calaby@gmail.com>

Acked-by: Anatolij Gustschin <agust@denx.de>
