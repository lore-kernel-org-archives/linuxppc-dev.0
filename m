Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A17DADDFB7
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 00:59:21 +1100 (EST)
Message-Id: <4C301539-D8EE-4E76-8E33-FF6493E311F7@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>
In-Reply-To: <20081013045116.GA11637@ime.usp.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: enable heap randomization for linkstations
Date: Tue, 28 Oct 2008 08:58:48 -0500
References: <20081013040703.GA11059@ime.usp.br>
	<20081013045116.GA11637@ime.usp.br>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 12, 2008, at 11:51 PM, Rog=E9rio Brito wrote:

> The current defconfig for Linkstation/Kuroboxes has the "Disable Heap
> Randomization" option enabled.
>
> Since some of these machines are facing the internet, it helps to have
> heap randomization enabled. This patch enables it.
>
>
> Signed-off-by: Rog=E9rio Brito <rbrito@ime.usp.br>
>
> ---


applied to merge.

- k=
